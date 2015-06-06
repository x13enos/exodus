myapp.application.module 'PlayerModule', (MyModule) ->
  MyModule.change_status = () ->
    if myapp.libs.settings.active_player
      myapp.libs.settings.active_player = false
      myapp.application.ScreenModule.block()
    else
      myapp.application.ScreenModule.unblock()
      new myapp.views.GameAlert({ text:"Your Turn" }).render()
      myapp.libs.settings.active_player = true

