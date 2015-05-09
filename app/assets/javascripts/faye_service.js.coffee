FayeService = ->
  this.client = new Faye.Client('http://localhost:9292/faye')
  ''

FayeService.prototype.subscribe_on_notifications = ->
  this.client.subscribe '/'+ current_user_token + '/notifications', (message) ->
    if message['type'] == 1
      button = $('.send_invite[user-token=' + message['sender'] + ']')
      href = root_url + 'game/new?token=' + message['sender']
      link = "<a class='btn btn-success' href='" + href + "'>Join to game</a>"
      button.parent().append(link)
      button.remove()

FayeService.prototype.subscribe_on_creating_game = ->
  this.client.subscribe '/' + current_user_token +  '/game/new', () ->
    window.location.replace root_url + "game"


$ ->
  faye_service = new FayeService()
  faye_service.subscribe_on_notifications()
  faye_service.subscribe_on_creating_game()

