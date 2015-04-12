myapp.collections.Gems = Backbone.Collection.extend
  model: myapp.models.Gem

  remove_gems: (indexes) ->
    that = this
    _.each indexes, (i) ->
      gem = that.findWhere({ index: i })
      if gem
        gem.destroy()





