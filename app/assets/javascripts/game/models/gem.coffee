myapp.models.Gem = Backbone.Model.extend

  urlRoot: '/gems'

  methodUrl:
    'gem_move': '/gems/move'

  sync: (method, model, options, view) ->

    if model.methodUrl && model.methodUrl[method.toLowerCase()]
      options = options || {}
      options.url = model.methodUrl[method.toLowerCase()]

    Backbone.sync(method, model, options)

  update_column_and_row: () ->
    this.set(myapp.application.GemsModule.get_new_positions(this.attributes.index))



