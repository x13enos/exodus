myapp.views.MainItemView = Backbone.Marionette.ItemView.extend
  template: false,

  onRender: () ->
    myapp.layers.paper = Raphael('board', 800, 800)
    myapp.layers.screen = Raphael('screen', 800, 800)
    new myapp.views.BoardItemView().render()

