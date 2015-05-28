###global define ###

'use strict'

define [
  'jquery'
  'es5/growl',
  './broadcast'
], ($, Growl) ->

  growl = new Growl
  notifica = (t, m) ->
    growl.notifica t, m
    return

  $.Broadcast('facebook').subscribe notifica

  return
