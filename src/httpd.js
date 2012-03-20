var http;

http = require('http');

exports.run = function(route, handle) {
  var server;
  server = http.createServer(function(request, response) {
    var postData;
    console.log('Request received.');
    request.setEncoding('utf-8');
    postData = '';
    request.addListener('data', function(dataChunk) {
      return postData += dataChunk;
    });
    return request.addListener('end', function() {
      return route(handle, request, response, postData);
    });
  });
  server.listen(1380, '127.0.0.1');
  return console.log('HTTP Server running at 127.0.0.1:1380');
};
