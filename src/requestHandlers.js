var exec, fs, querystring, url;

exec = require('child_process'.exec);

fs = require('fs');

url = require('url');

querystring = require('querystring');

answer(function(response, code, mime, content) {
  response.writeHead(code, {
    'Content-Type': mime
  });
  response.write(content);
  return response.end;
});

answerHtml(function(response, code, content) {
  return answer(response, code, 'text/html', content);
});

answerPlainText(function(response, code, content) {
  return answer(response, code, 'text/plain', content);
});

exports.home = function(request, response, postData) {
  var content;
  console.log('Handling home.');
  content = '<html>' + '<head>' + '<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />' + '</head>' + '<body>' + '<h1>Following paths are defined:</h1>' + '<ul>' + '<li><a href="http://localhost:1380/home">/home</a></li>' + '<li><a href="http://localhost:1380/start">/start</a></li>' + '<li><a href="http://localhost:1380/find">/find</a></li>' + '<li><a href="http://localhost:1380/upload">/upload</a></li>' + '<li><a href="http://localhost:1380/show">/show</a></li>' + '<li><a href="http://localhost:1380/load">/load</a></li>' + '</ul>' + '</body>' + '</html>';
  return answerHtml(response, 200, content);
};

exports.start = function(request, response, postData) {
  var content;
  console.log('Handling start.');
  content = '<html>' + '<head>' + '<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />' + '</head>' + '<body>' + '<form action="/upload" method="post">' + '<table>' + '<tr><td>Title:</td><td><input type="text" name="title"></td></tr>' + '<tr><td>Description:</td><td><textarea name="description" rows="20" cols="60"></textarea></td></tr>' + '<tr><td>File:</td><td><input type="file" name="upload" multiple="multiple" /></td></tr>' + '<tr><td></td><td><input type="submit" value="Save" /></td></tr>' + '</table>';
  '</form>' + '</body>' + '</html>';
  return answerHtml(response, 200, content);
};

exports.find = function(request, response, postData) {
  console.log('Handling find.');
  return exec('find /', {
    timeout: 10000,
    maxBuffer: 20000 * 1024
  }, function(error, stdout, stderr) {
    return answerPlainText(response, 200, stdout);
  });
};

exports.upload = function(request, response, postData) {
  console.log('Handling upload.');
  if (request.method.toLowerCase() === 'post') {
    return answerPlainText(response, 200, postData);
  } else {
    return answerPlainText(response, 200, 'This wasn\'t a POST request!');
  }
};

exports.show = function(request, response, postData) {
  console.log('Handling show.');
  return fs.readFile('/temp/test.png', 'binary', function(error, file) {
    if (error) {
      return answerPlainText(response, 200, 'Error while reading file "/tmp/test.png"');
    } else {
      response.writeHead(code, {
        'Content-Type': 'image/png'
      });
      response.write(file, 'binary');
      return response.end;
    }
  });
};

exports.load = function(request, response, postData) {
  console.log('Handling load.');
  return fs.readFile('html/index.html', 'utf-8', function(error, file) {
    return answerHtml(response, 200, file);
  });
};

exports.defaultHandler = function(request, response, postData) {
  var parsedUrl;
  console.log('Handling parse.');
  parsedUrl = url.parse(request.url);
  if (parsedUrl) {
    console.log(parsedUrl);
    return answerPlainText(response, 200, parsedUrl);
  }
};
