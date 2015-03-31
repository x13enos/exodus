myapp.collections.Gems = Backbone.Collection.extend
  model: myapp.models.Gem

  remove_gems: (indexes) ->
    that = this
    _.each indexes, (i) ->
      k = i
      console.log(i)
      while Math.floor(k / 8) >= 0
        gem = that.findWhere({ index: k.toString() })
        if gem
          gem.destroy()
        k -= 8





