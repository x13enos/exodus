myapp.application.module 'EventsModule', (MyModule) ->

  MyModule.init = () ->
    add_gem_to_collection()
    remove_gems_from_collection()
    add_gem_frame_to_collection()
    remove_gem_frame_from_collection()
    change_position_gem()

  add_gem_to_collection = () ->
    myapp.collections.gems.on "add", (gem) ->
      new myapp.views.AddGemItemView(model: gem).render()

  remove_gems_from_collection = () ->
    myapp.collections.gems.on "remove", (gem) ->
      new myapp.views.RemoveGemItemView(model: gem).render()

  add_gem_frame_to_collection = () ->
    myapp.collections.gem_frames.on "add", (gem_frame) ->
      new myapp.views.SelectGemItemView(model: gem_frame).render()

  remove_gem_frame_from_collection = () ->
    myapp.collections.gem_frames.on "remove", (gem_frame) ->
      new myapp.views.UnselectGemItemView(model: gem_frame).render()

  change_position_gem = () ->
    myapp.collections.gems.on 'change:index', (gem) ->
      new myapp.views.ChangePositionGemItemView(model: gem).render()







