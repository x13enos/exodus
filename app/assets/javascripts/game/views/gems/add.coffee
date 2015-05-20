  myapp.views.AddGemItemView = Marionette.ItemView.extend
    template: false,

    initialize: () ->
      this.attrs = this.model.attributes

    onRender: () ->
      that = this
      this.attrs.image.attr(position_before_animate(this.attrs))
      this.attrs.image.attr({ width: 70, height: 70 })
      this.attrs.image.attr('src', myapp.libs.settings.images[this.attrs.type].src)
      this.attrs.image.animate(position_after_animate(this.attrs), 400)
      this.attrs.image.click () ->
        myapp.controllers.gems.select(that.model)

    position_before_animate = (t) -> 
      { x: 15 + (t.column * 100), y: -15 - (t.top_offset * 100) }

    position_after_animate = (t) -> 
      { x: 15 + (t.column * 100), y: 15 + (t.row * 100) }

