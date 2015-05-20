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


