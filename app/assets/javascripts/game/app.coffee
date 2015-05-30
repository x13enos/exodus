window.myapp =
  views: {},
  models: {},
  collections: {},
  libs: {},
  layers: {},
  controllers: {}

myapp.application = new Marionette.Application()

myapp.application.on "start", () ->
  myapp.libs.settings.game_id = $('#board').attr('game-id') 
  myapp.libs.settings.gems_type = window.gems_type 
  myapp.libs.settings.mana_gems = window.mana_gems


