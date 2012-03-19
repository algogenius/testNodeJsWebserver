http = require('http')

exports.run = (route, handle) ->

  onRequest (request, response) ->
    console.log 'Request received.'
    request.setEncoding 'utf-8'
    postData = ''        
    request.addListener 'data', (dataChunk) ->
      postData += dataChunk;
    request.addListener 'end', () ->
      route handle, request, response, postData

  server = http.createServer onRequest;
  server.listen 1380, '127.0.0.1'
  console.log 'HTTP Server running at 127.0.0.1:1380'