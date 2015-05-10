myapp.application.module 'ScreenModule', (MyModule) ->

  MyModule.block =  ->
    new myapp.views.BlockScreenItemView().render()

  MyModule.unblock =  ->
    new myapp.views.UnblockScreenItemView().render()
