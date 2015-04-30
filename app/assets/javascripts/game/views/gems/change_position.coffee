myapp.views.ChangePositionGemItemView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes

  onRender: () ->
    t = myapp.application.GemsModule.get_new_positions(this.attrs.index) 
    this.attrs.image.animate(calculate_new_position(t), 400)


  calculate_new_position = (t) ->
    { x: 15 + (t.column * 100), y: 15 + (t.row * 100) }
