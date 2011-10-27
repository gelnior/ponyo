http = require('http')

vows = require('vows')
eyes = require('eyes')
assert = require('assert')
CategoryProvider = require("../models/models").CategoryProvider


class HttpClient

  get: (path, host, port, callback) ->
    client = http.createClient port, host
    request = client.request 'GET', '/',  {'host': host}
    request.end()
    request.on('end', callback)


client = new HttpClient

vows.describe('Services')

  .addBatch(
    'A client ':
      topic: () ->
        client.get('/', "localhost", 3000, @callback)

      'should respond with a 200 OK': (response) ->
        console.log response.statusCode
        assert.equal response.statusCode, 200
  )
  .export(module)
