FayeService = ->
  this.client = new Faye.Client('http://localhost:9292/faye')
  return null

FayeService.prototype.move_two_gems = ->
  this.client.subscribe '/'+ current_user_token + '/game/move_two_gems', (data) ->
    myapp.application.Gems_SwapTwoGems_Module.perform(_.values(data['gems_index']))
    setTimeout (->
      myapp.application.Gems_UpdateSituationOnBoard_Module.perform(data['respond'])
    ), 400
    setTimeout ( ->
      myapp.application.ScreenModule.unblock()
    ), 400 + (data['respond']['result'].length * 650)
    setTimeout ( ->
      new myapp.views.GameAlert({ text:"Your Turn" }).render()
    ), data['respond']['result'].length * 650



$ ->
  faye_service = new FayeService()
  faye_service.move_two_gems()

