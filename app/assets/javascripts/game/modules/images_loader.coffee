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
          myapp.models.board.sync(
            'starting_gems_position', 
             myapp.models.board, 
             { success: (data) ->
                 myapp.application.GemsModule.create(data)
               data: $.param({game_id: myapp.libs.settings.game_id})
             }
          ) 
      i++



