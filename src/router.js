var url;

url = require('url');

exports.route = function(handle, request, response, postData) {
  var pathname;
  pathname = url.parse(request.url).pathname;
  console.log('About to route a request for "' + pathname + '".');
  if (pathname.indexOf('..') !== -1) {
    response.writeHead(403, {
      'Content-Type': 'text/plain'
    });
    response.write('Shit fucking path hacker! Go hack some other site!');
    response.end();
  }
  if (typeof handle[pathname] === 'function') {
    return handle[pathname](request, response, postData);
  } else {
    return handle['defaultHandler'](request, response, postData);
  }
};
