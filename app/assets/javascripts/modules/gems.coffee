myapp.application.module 'GemsModule', (MyModule) ->

  MyModule.create = (gems_data) ->
    _.each gems_data, (gem) ->

      myapp.collections.gems.add(
        type: gem['type'],
        image: paper.image(),
        index: gem['index'],
        row: row(gem['index']),
        column: column(gem['index']),
        top_offset: gem['position']
      )

  MyModule.select = (gem) ->
    selected_gem = myapp.libs.settings.selected_gem
    if selected_gem
      check_gems_position(gem)
      myapp.libs.settings.selected_gem = false
      myapp.application.GemFramesModule.remove()
    else
      myapp.collections.gem_frames.add({ index: '1', gem: gem })
      myapp.libs.settings.selected_gem = gem

  MyModule.update_positions = (data) ->
    _.each data, (position_data) ->
      gem = myapp.collections.gems.findWhere({ index: position_data['old_index'] })
      gem.set({index: position_data['new_index']}) 

  MyModule.get_new_positions = (index) ->
    { column: column(index), row: row(index) }

  check_gems_position = (gem) ->
    first_index = myapp.libs.settings.selected_gem.attributes.index
    second_index = gem.attributes.index
    if stones_in_the_neighborhood(first_index, second_index)
      myapp.application.Gems_SwapTwoGems_Module.perform([first_index, second_index])
      _.delay(sync_gems_position, 500, { g: gem, f_i: first_index, s_i: second_index })
    else
      alert "Fucking mistake!"
      myapp.libs.settings.selected_gem = false

  stones_in_the_neighborhood = (f_i, s_i) ->
    gems_in_same_row(f_i, s_i) || gems_in_same_column(f_i, s_i)

  gems_in_same_row = (f_i, s_i) ->
    row(f_i) == row(s_i) && (f_i == (s_i + 1)  || f_i == (s_i - 1))

  gems_in_same_column = (f_i, s_i) ->
    column(f_i) == column(s_i) && (f_i == (s_i + 8)  || f_i == (s_i - 8))

  row = (gem_index) ->
    (gem_index / 8) | 0

  column = (gem_index) ->
    ((gem_index / 8) - row(gem_index)) * 8

  sync_gems_position = ( params ) ->
    params['g'].sync('gem_move', params['g'], 
      data: $.param( 
        ids: [params['f_i'], params['s_i']], 
        game_id: myapp.libs.settings.game_id 
      ),
      success: (data) ->
        myapp.application.Gems_UpdateSituationOnBoard_Module.perform(data)
    )
