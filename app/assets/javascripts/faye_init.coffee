$ ->
  faye = new Faye.Client('http://localhost:9292/faye')
  faye.subscribe '/game', (data) ->
    alert(data)
