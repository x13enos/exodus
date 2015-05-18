myapp.application.module 'Gems_UpdateSituationOnBoard_Module', (MyModule) ->

  MyModule.perform = (data) ->
    if data['status'] == 'success' || data['status'] == 'end'
      change_gem_positions(data)
    else if data['status'] == 'error'
      return_gems_on_init_places(data)

  change_gem_positions = (data) ->
    _.each data['result'], (data_step, i) ->
      update_position(data_step, i)

    change_active_player(data)
    if data['status'] == 'end'
      finish_game(data)

  change_active_player = (data) ->
    setTimeout (->
      myapp.application.PlayerModule.change_status()
    ), data['result'].length * 650 


  finish_game = (data) ->
    setTimeout (->
      myapp.application.ScreenModule.block()
      alert("You " + data['sub_status'])
      window.location.replace root_url
    ), data['result'].length * 650 

  return_gems_on_init_places = (data) ->
      myapp.application.Gems_SwapTwoGems_Module.perform(data['gems_indexes'])

  update_position = (data, step) ->
    setTimeout (->
      myapp.collections.gems.remove_gems(data['delete_gems'])
      move_gem(data['new_gems_position']['move_gems'])
      create_new_gems(data['new_gems_position']['new_gems'])
    ), 0 + ( step * 650 )

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


