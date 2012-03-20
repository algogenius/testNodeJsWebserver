url = require 'url'

exports.route = (handle, request, response, postData) ->
  pathname = url.parse(request.url).pathname  
  console.log 'About to route a request for "' + pathname + '".'
    
  if pathname.indexOf('..') != -1 
    response.writeHead 403, {'Content-Type': 'text/plain'}
    response.write 'Shit fucking path hacker! Go hack some other site!'
    response.end()
    
  if typeof handle[pathname] == 'function'
    handle[pathname] request, response, postData
  else
    handle['defaultHandler'] request, response, postData