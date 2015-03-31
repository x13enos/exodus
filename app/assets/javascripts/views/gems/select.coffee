myapp.views.SelectGemItemView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes
    this.gem = this.attrs.gem

  onRender: () ->
    rectangle = new Path.Rectangle
        point: new_positions(this.gem.attributes),
        size: [60, 60],
        strokeColor: 'pink'
    rectangle.rotate(45)
    rectangle.strokeWidth = 3
    this.attrs.object = rectangle
    paper.view.draw()

  new_positions = (t) -> 
    new Point([20 + (t.column * 100), 20 + (t.row * 100)] )

