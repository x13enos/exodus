myapp.application.module 'Gems_UpdateAll', (MyModule) ->

  MyModule.perform = (data) ->
    myapp.collections.gems.remove_all_gems()
    create_new_gems(data)

  create_new_gems = (data) ->
    console.log(data)
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


