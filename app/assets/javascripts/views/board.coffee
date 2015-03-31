myapp.views.BoardItemView = Marionette.ItemView.extend
    template: false,

    onRender: () ->
      this.draw_board_background()
      this.draw_board_frame()
      this.draw_vertical_lines()
      this.draw_horizontal_lines()
      paper.view.draw()

    draw_board_background: () ->
      from = new Point(0, 0)
      to = new Point(800, 800)
      path = new Path.Rectangle(from, to)
      path.fillColor = "#3a3838"

    draw_board_frame: () ->
      from = new Point(0, 0)
      to = new Point(800, 800)
      path = new Path.Rectangle(from, to)
      path.strokeColor = '#FBDB65'
      path.strokeWidth = 10

    draw_vertical_lines: () ->
      x = 100
      t = 1
      while t <= 7
        from = new Point(x, 0)
        to = new Point(x, 800)
        path = new Path.Line(from, to)
        path.strokeColor = '#FBDB65'
        path.strokeWidth = 10
        x += 100
        t += 1

    draw_horizontal_lines: () ->
      y = 100
      t = 1
      while t <= 7
        from = new Point(0, y)
        to = new Point(800, y)
        path = new Path.Line(from, to)
        path.strokeColor = '#FBDB65'
        path.strokeWidth = 10
        y += 100
        t += 1
