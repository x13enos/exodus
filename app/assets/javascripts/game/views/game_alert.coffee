myapp.views.GameAlert = Marionette.ItemView.extend
  template: false,

  initialize: (object) ->
    this.text = object['text'] 
    console.log(this.text)
  
  onRender: () ->
    text = myapp.layers.paper.text(400,400, this.text)
    text.attr({ fill: "#fff", stroke: "#fff", "stroke-width": 1, "stroke-linecap": "round", translation: "100 100", 'font-size': "1"})
    removeText = ->
      text.remove()

    text.animate({'font-size': '120'}, 600, _.delay(removeText, 900))



