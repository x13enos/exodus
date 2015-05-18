myapp.views.RemoveGemItemView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes

  onRender: () ->
    this.attrs.image.remove()
    if this.attrs.type == 4
      if myapp.libs.settings.active_player
        $('#opponent_hp').text(parseInt($('#opponent_hp').text()) - 1)
      else
        $('#player_hp').text(parseInt($('#player_hp').text()) - 1)



