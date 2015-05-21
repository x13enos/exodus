myapp.views.RemoveGemItemView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes

  onRender: () ->
    this.attrs.image.remove()
    if this.attrs.type == 4
      if myapp.libs.settings.active_player
        new_value = parseInt($('.opponent_data .player_hp .value').text()) - 1
        $('.opponent_data .player_hp .value').text(new_value)
      else
        new_value = parseInt($('.player_data .player_hp .value').text()) - 1
        $('.player_data .player_hp .value').text(new_value)
    else
      gem_type = myapp.libs.settings.gems_type[this.attrs.type]
      if myapp.libs.settings.active_player
        selector = $('.player_data .player_' + gem_type  + ' .value').first()
        $(selector).text(parseInt($(selector).text()) + 1)
      else
        selector = $('.opponent_data .player_' + gem_type  + ' .value').first()
        $(selector).text(parseInt($(selector).text()) + 1)





