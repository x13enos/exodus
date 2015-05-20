$ ->
  myapp.application.start()
  myapp.models.board = new myapp.models.Board
  myapp.collections.gems = new myapp.collections.Gems
  myapp.collections.gem_frames = new myapp.collections.GemFrames
  myapp.controllers.gems = new myapp.controllers.Gems

  myapp.application.EventsModule.init()

  new myapp.views.MainItemView().render()
  myapp.application.ImagesLoaderModule.lazy_load()




