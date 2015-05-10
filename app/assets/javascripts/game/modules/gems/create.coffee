myapp.application.module 'Gems_Create_Module', (MyModule) ->

  MyModule.perform = (gems_data) ->
    _.each gems_data, (gem) ->

      myapp.collections.gems.add(
        type: gem['type'],
        image: myapp.layers.paper.image(),
        index: gem['index'],
        row: row(gem['index']),
        column: column(gem['index']),
        top_offset: gem['position']
      )

  row = (gem_index) ->
    (gem_index / 8) | 0

  column = (gem_index) ->
    ((gem_index / 8) - row(gem_index)) * 8

