myapp.application.module 'Gems_UpdateSituationOnBoard_Module', (MyModule) ->

  MyModule.perform = (data) ->
    if data['status'] == 'success'
      change_gem_positions(data['result'])
    else if data['status'] == 'error'
      return_gems_on_init_places(data)

  change_gem_positions = (data) ->
    _.each data, (data_step, i) ->
      setTimeout (->
        update_position(data_step)
      ), 0 + ( i * 650 )

  return_gems_on_init_places = (data) ->
      myapp.application.Gems_SwapTwoGems_Module.perform(data['gems_indexes'])

  update_position = (data) ->
    myapp.collections.gems.remove_gems(data['delete_gems'])
    move_gem(data['new_gems_position']['move_gems'])
    create_new_gems(data['new_gems_position']['new_gems'])

  move_gem = (data) ->
    _.each data, (gem) ->
      index = parseInt(gem['index'])
      old_index = parseInt(gem['old_index'])
      myapp.collections.gems.findWhere({ index: old_index }).set({index: index })

  create_new_gems = (data) ->
    _.each data, (gem) ->
      position = myapp.application.GemsModule.get_new_positions(gem['index'])
      myapp.collections.gems.add(
        type: gem['type'],
        image: myapp.layers.paper.image(),
        index: gem['index'],
        row: position['row'],
        column: position['column'],
        top_offset: gem['position']
      )


