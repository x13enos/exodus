myapp.application.module 'GemFramesModule', (MyModule) ->

  MyModule.remove = () ->
    _.each myapp.collections.gem_frames.models, (gem_frame) ->
      gem_frame.destroy()

