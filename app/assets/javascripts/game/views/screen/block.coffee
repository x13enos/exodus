myapp.views.BlockScreenItemView = Marionette.ItemView.extend
  template: false,

  onRender: () ->
    $('#screen').css('z-index', '101')
