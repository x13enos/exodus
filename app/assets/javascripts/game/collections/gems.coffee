myapp.collections.Gems = Backbone.Collection.extend
  model: myapp.models.Gem

  remove_gems: (indexes) ->
    that = this
    _.each indexes, (i) ->
      gem = that.findWhere({ index: i })
      if gem
        new myapp.views.Players_UpdateAttributesView(model: gem).render()
        gem.destroy()


  remove_all_gems: () ->
    _.each @.toArray(), (gem) ->
      gem.destroy()




