'use strict'

define [
  'facebook'
  'jquery'
  './broadcast'
], (FB, $) ->

  callOnce = false

  # Singleton
  class Api
    connect: ->
      d = $.Deferred()
      if callOnce == true
        d.reject()
      else
        callOnce = true
        FB.init
          appId: '1395650490714118'
          status: true
          cookie: true
          xfbml: true
          version: 'v2.3'

        FB.Event.subscribe 'auth.authResponseChange', (response) ->
          console.debug '------------------------>auth.authResponseChange'
          console.log response
          return
        d.resolve 'Api', 'Api do Facebook inicializado'
      d.promise()

    login: ->
      d = $.Deferred()
      FB.login ((res) ->
        if res and res.status == 'connected'
          d.resolve 'Login', 'Login efetuado com sucesso'
          $.Broadcast('facebook.logado').publish true
        else
          d.reject 'Login', res.status
        return
      ), scope: 'email,user_birthday'
      d.promise()

    logout: ->
      d = $.Deferred()
      FB.logout (res) ->
        if res and res.status == 'unknown'
          d.resolve 'Logout', 'Logout efetuado com sucesso'
          $.Broadcast('facebook.logado').publish false
        else
          d.reject 'Logout', res.status
        return
      d.promise()

    status: ->
      d = $.Deferred()
      FB.getLoginStatus (res) ->
        if res and res.status == 'connected'
          d.resolve true
        else
          d.reject false
        return
      d.promise()

    user: ->
      d = $.Deferred()
      FB.api '/me', { fields: 'id,name,birthday,email,gender' }, (res) ->
        if res and res.name
          d.resolve 'User', "Olá #{res.name}!"
        else
          d.reject 'User', res.status
        return
      d.promise()

  ->
    instance = instance or new Api
    instance
