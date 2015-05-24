FayeService = ->
  this.client = new Faye.Client('http://localhost:9292/faye')
  return null

FayeService.prototype.move_two_gems = ->
  this.client.subscribe '/'+ current_user_token + '/game/move_two_gems', (data) ->
    myapp.application.Gems_SwapTwoGems_Module.perform(_.values(data['gems_index']))
    setTimeout (->
      myapp.application.Gems_UpdateSituationOnBoard_Module.perform(data['result'])
    ), 400
    setTimeout ( ->
      myapp.application.ScreenModule.unblock()
    ), 400 + (data['result']['result'].length * 650)
    setTimeout ( ->
      new myapp.views.GameAlert({ text:"You're Turn" }).render()
    ), data['result']['result'].length * 650



$ ->
  faye_service = new FayeService()
  faye_service.move_two_gems()

