myapp.views.RemoveGemItemView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes

  onRender: () ->
    this.attrs.image.remove()
