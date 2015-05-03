UserService = ->

UserService.prototype.send_invite = (user_token) ->
  $.ajax
    url: '/users/' + user_token + '/send_invite_to_game'
    type: 'POST'
    dataType: 'json'
    success: (data) ->
      console.log('success')
      return
    error: (data) ->
      console.log('error')
      return

$ ->
  user_service = new UserService()

  $('.send_invite').click ->
    user_token = $(this).attr('user-token')
    user_service.send_invite(user_token)

