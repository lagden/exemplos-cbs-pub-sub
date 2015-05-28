###global define ###

'use strict'

define [
  'jquery'
], ($) ->
  Broadcast = {}

  $.Broadcast = (id) ->
    topic = id and Broadcast[id]
    if !topic
      callbacks = $.Callbacks()
      topic =
        publish: callbacks.fire
        subscribe: callbacks.add
        unsubscribe: callbacks.remove
      if id
        Broadcast[id] = topic
    topic

  return
