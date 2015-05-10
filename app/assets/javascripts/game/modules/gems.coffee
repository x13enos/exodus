myapp.application.module 'GemsModule', (MyModule) ->

  MyModule.update_positions = (data) ->
    _.each data, (position_data) ->
      gem = myapp.collections.gems.findWhere({ index: position_data['old_index'] })
      gem.set({index: position_data['new_index']}) 

  MyModule.get_new_positions = (index) ->
    { column: column(index), row: row(index) }

  row = (gem_index) ->
    (gem_index / 8) | 0

  column = (gem_index) ->
    ((gem_index / 8) - row(gem_index)) * 8

