'use strict'

define [
  'jquery'
  './components/fb'
  './components/notifica'
], ($, Api) ->

  # Inicializa a Api do Facebook
  fb = new Api

  # Handler do clique dos botões
  callApiMethod = (m) ->
    fb[m]()
      .then $.Broadcast('facebook').publish
      .fail $.Broadcast('facebook').publish
    return

  # Seleciona todos os botões
  $btns = $ '.bt'

  # Adiciona o evento de clique nos botões
  $btns.on 'click', (evt) ->
    callApiMethod @dataset.method
    return

  # Subscribe Handler qunado fizer login via FB
  $.Broadcast('facebook.logado').subscribe (v) ->
    m = ['show', 'hide']
    a = if v then 1 else 0
    b = a ^ 1
    $btns.filter('.bt[data-method="login"]')[m[a]]()
    $btns.filter('.bt[data-method="logout"]')[m[b]]()
    return

  # Esconde os botões
  $btns.hide()

  # Verifica o Facebook e o Status
  fb.connect()
    .then (t, m) ->
      $.Broadcast('facebook').publish t, m
      fb.status()
        .then $.Broadcast('facebook.logado').publish
        .fail $.Broadcast('facebook.logado').publish

      # Mostra os botões
      $btns.show()
      return

  return
