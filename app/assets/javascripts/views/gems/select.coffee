myapp.views.SelectGemItemView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes
    this.gem = this.attrs.gem

  onRender: () ->
    rectangle = paper.rect((20 + (this.gem.attributes.column * 100)), (20 + (this.gem.attributes.row * 100)), 60, 60)
    rectangle.attr({ stroke: 'pink', 'stroke-width': 3 })
    this.attrs.object = rectangle

  new_positions = (t) -> 
    { x: 20 + (t.column * 100), y: 20 + (t.row * 100) }

