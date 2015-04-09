$ ->
  myapp.application.start()
  myapp.models.board = new myapp.models.Board
  myapp.collections.gems = new myapp.collections.Gems
  myapp.collections.gem_frames = new myapp.collections.GemFrames

  myapp.application.EventsModule.init()
  myapp.application.ImagesLoaderModule.lazy_load()
  new myapp.views.MainItemView().render()
 
