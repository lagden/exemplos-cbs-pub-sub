'use strict'

define 'config', ->
  requirejs.config
    baseUrl: '/js/lib'
    paths:
      app: '../app'
      templates: '../templates'
      facebook: '//connect.facebook.net/pt_BR/sdk'
    shim:
      facebook:
        exports: 'FB'

  return
