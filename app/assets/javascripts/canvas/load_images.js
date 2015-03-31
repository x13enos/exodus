function onload_images(hash_images){
  var images = _.map(hash_images, function(img, name){ return img })
  var imageCount = images.length;
  var imagesLoaded = 0;
  for(var i=0; i<imageCount; i++){
      images[i].onload = function(){
          imagesLoaded++;
          if(imagesLoaded == imageCount){
            board.initialization()
          }
      }
  }
}

function load_image_for_board(){
  var images = []
  var image_name_array = ['blue_gem', "green_gem", "red_gem", "yellow_gem", "scull", "star", "coins"]
  _.map(image_name_array, function(name){
    var img = new Image;
    img.src = '/assets/' + name + '.png';
    images.push(img);
  })
  return images;
}
