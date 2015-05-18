myapp.application.module 'ImagesLoaderModule', (MyModule) ->
  MyModule.lazy_load = () ->
    images = []
    image_name_array = ['blue_gem', "green_gem", "red_gem", "yellow_gem", "scull", "star", "coins"]
    _.map image_name_array, (name) ->
      img = new Image
      img.src = '/assets/' + name + '.png'
      images.push(img)

    myapp.libs.settings.images = images
    imageCount = images.length
    imagesLoaded = 0
    i = 0
    while i < imageCount
      images[i].onload = () ->
        imagesLoaded++
        if imagesLoaded == imageCount
          myapp.application.Gems_Create_Module.perform(current_gems_position)
          window.setTimeout ( ->
            if active_player == false
              myapp.application.ScreenModule.block()
            else
              myapp.libs.settings.active_player = true
          ), 100
      i++



