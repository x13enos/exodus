  myapp.views.AddGemItemView = Marionette.ItemView.extend
    template: false,

    initialize: () ->
      this.attrs = this.model.attributes

    onRender: () ->
      that = this
      this.attrs.image.attr(new_positions(this.attrs))
      this.attrs.image.attr({ width: 70, height: 70 })
      this.attrs.image.attr('src', myapp.libs.settings.images[this.attrs.type].src)
      this.attrs.image.click () ->
        that.model.select()

    new_positions = (t) -> 
      { x: 15 + (t.column * 100), y: 15 + (t.row * 100) }

