myapp.views.UnblockScreenItemView = Marionette.ItemView.extend
  template: false,

  onRender: () ->
    $('#screen').css('z-index', '99')
