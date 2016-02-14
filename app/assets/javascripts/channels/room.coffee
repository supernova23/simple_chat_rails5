App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    div = $(document.createElement("div"))
    strong = $(document.createElement("strong"))
    strong.text(data.username)
    text = document.createTextNode(" : "+data.content)
    div.append(strong).append(text)
    $(".messages").append(div)
  speak: (data) ->
    @perform 'speak', data

  $(document).on("keypress", (e) ->
    if e.keyCode is 13
      username = $(this).find("#username")
      message = $(this).find("#message")
      App.room.speak {content: message.val(), username: username.val()}
      e.preventDefault()
      message.val("")
  )