myapp.models.Board = Backbone.Model.extend

  defaults:
    width: 800
    height: 800
    elements_array: _.range(7)

  urlRoot: '/game'

  methodUrl:
    'starting_gems_position': '/game/starting_gems_position'

  sync: (method, model, options, view) ->

    if model.methodUrl && model.methodUrl[method.toLowerCase()]
      options = options || {}
      options.url = model.methodUrl[method.toLowerCase()]

    Backbone.sync(method, model, options)



