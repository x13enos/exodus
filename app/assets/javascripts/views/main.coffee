myapp.views.MainItemView = Backbone.Marionette.ItemView.extend
  template: false,

  onRender: () ->
    paper.install(window)
    paper.setup('board')
    paper.main_layer = new Layer()
    new myapp.views.BoardItemView().render()

