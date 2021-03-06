myapp.views.Players_UpdateAttributesView = Marionette.ItemView.extend
  template: false,

  initialize: () ->
    this.attrs = this.model.attributes

  onRender: () ->
    change_user_params(this.attrs.type)

  change_user_params = (gem) ->
    gem_type = myapp.libs.settings.gems_type[gem]
    selector = $(get_need_selector(gem_type))
    current_value = parseInt($(selector).children('.value').text())
    new_value = calculate_new_value(current_value, gem, selector)
    $(selector).children('.value').text(new_value)

  calculate_new_value = (value, gem, selector) ->
    if gem.toString() == _.invert(myapp.libs.settings.gems_type)['hp']
      value -= 1
    else
      if user_not_reached_limit_mana(value, gem, selector)
        value += 1

  user_not_reached_limit_mana = (value, gem, selector) ->
    if _.indexOf(_.keys(myapp.libs.settings.mana_gems), gem.toString()) >= 0
      parseInt($(selector).children('.max_value').text()) > value
    else
      return true

  get_need_selector = (gem) ->
    if gem == 'hp'
      if myapp.libs.settings.active_player
        '.opponent_data .player_hp'
      else
        '.player_data .player_hp'
    else
      if myapp.libs.settings.active_player
        '.player_data .player_' + gem
      else
        '.opponent_data .player_' + gem




