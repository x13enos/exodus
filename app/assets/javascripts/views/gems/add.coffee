  myapp.views.AddGemItemView = Marionette.ItemView.extend
    template: false,

    initialize: () ->
      this.attrs = this.model.attributes

    onRender: () ->
      that = this
      this.attrs.image.position = new_positions(this.attrs)
      this.attrs.image.image = myapp.libs.settings.images[this.attrs.type]
      this.attrs.image.on 'click', () ->
        that.model.select()
      paper.view.draw()

    new_positions = (t) -> 
      new Point([50 + (t.column * 100), 50 + (t.row * 100)] )

