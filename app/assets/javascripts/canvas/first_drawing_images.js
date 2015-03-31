function draw_images_on_board(){
  gems_layer = new Layer()
  _.each(board.init_filling_array, function(row, row_index){
    _.each(row, function(elem, column_index){
      var image = new Raster(board.images[elem], [50 + (column_index * 100), 50 + (row_index * 100)] )
      image.data.number = (8*row_index) + column_index
      image.layer = gems_layer
      image.onClick = function(){highlight(image)}
    })
  })
}

function highlight(raster){
  y_coord = raster.position.y - 5
  for (var i = 0; i < 5; i++) {
    raster.position = new Point(raster.position.x, raster.position.y - 1)
  }
}
