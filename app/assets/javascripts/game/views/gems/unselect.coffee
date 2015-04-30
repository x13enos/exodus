myapp.views.UnselectGemItemView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes

  onRender: () ->
    this.attrs.object.remove()
