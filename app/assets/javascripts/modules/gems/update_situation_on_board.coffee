myapp.application.module 'Gems_UpdateSituationOnBoard_Module', (MyModule) ->

  MyModule.perform = (data) ->
    t = data[0]
    console.log t
    myapp.collections.gems.remove_gems(t['delete_gems'])
    move_gem(t['new_gems_position']['move_gems'])
    create_new_gems(t['new_gems_position']['new_gems'])

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
        image: paper.image(),
        index: gem['index'],
        row: position['row'],
        column: position['column'],
        top_offset: gem['position']
      )


