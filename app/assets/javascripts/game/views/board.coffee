myapp.views.BoardItemView = Marionette.ItemView.extend
    template: false,

    onRender: () ->
      this.draw_translucent_layer()
      this.draw_board_background()
      this.draw_board_frame()
      this.draw_vertical_lines()
      this.draw_horizontal_lines()

    draw_translucent_layer: () ->
      myapp.layers.screen.rect(0, 0, 800, 800).attr({ fill:'#A9A9A9', opacity: '0.25'})

    draw_board_background: () ->
      myapp.layers.paper.rect(0, 0, 800, 800).attr('fill', '#3a3838')

    draw_board_frame: () ->
      myapp.layers.paper.rect(0,0,800,800).attr({ stroke: '#FBDB65', 'stroke-width': 10 })

    draw_vertical_lines: () ->
      x = 100
      t = 1
      while t <= 7
        myapp.layers.paper.rect(x,0,x,800).attr({ stroke: '#FBDB65', 'stroke-width': 10 })
        x += 100
        t += 1

    draw_horizontal_lines: () ->
      y = 100
      t = 1
      while t <= 7
        myapp.layers.paper.rect(0,y,800,y).attr({ stroke: '#FBDB65', 'stroke-width': 10 })
        y += 100
        t += 1
