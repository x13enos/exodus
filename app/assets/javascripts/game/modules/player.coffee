myapp.application.module 'PlayerModule', (MyModule) ->
  MyModule.change_status = () ->
    if myapp.libs.settings.active_player
      myapp.libs.settings.active_player = false
    else
      myapp.libs.settings.active_player = true

