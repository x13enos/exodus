myapp.application.module 'Gems_SwapTwoGems_Module', (MyModule) ->

  MyModule.perform = (indexes) ->
    indexes = [parseInt(indexes[0]), parseInt(indexes[1])]
    first_gem = myapp.collections.gems.findWhere({ index: indexes[0] })
    second_gem = myapp.collections.gems.findWhere({ index: indexes[1] })
    first_gem.set({ index: indexes[1] })
    second_gem.set({ index: indexes[0] })
