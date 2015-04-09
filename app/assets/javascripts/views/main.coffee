myapp.views.MainItemView = Backbone.Marionette.ItemView.extend
  template: false,

  onRender: () ->
    window.paper = Raphael('board', 800, 800)
    new myapp.views.BoardItemView().render()

