FayeService = ->
  this.client = new Faye.Client('http://localhost:9292/faye')
  return null

FayeService.prototype.move_two_gems = ->
  this.client.subscribe '/'+ current_user_token + '/game/move_two_gems', (data) ->
    myapp.application.Gems_SwapTwoGems_Module.perform(_.values(data['gems_index']))
    setTimeout (->
      myapp.application.Gems_UpdateSituationOnBoard_Module.perform(data['respond'])
    ), 400


$ ->
  faye_service = new FayeService()
  faye_service.move_two_gems()

