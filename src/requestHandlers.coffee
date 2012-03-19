exec = require 'child_process' .exec
fs = require 'fs'
url = require 'url'
querystring = require 'querystring'

answer (response, code, mime, content) ->
  response.writeHead code, {'Content-Type': mime}
  response.write content
  response.end    

answerHtml (response, code, content) ->
  answer response, code, 'text/html', content

answerPlainText (response, code, content) ->
  answer response, code, 'text/plain', content

exports.home = (request, response, postData) ->
  console.log 'Handling home.'
  content = '<html>' +
    '<head>' +
    '<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />' +
    '</head>' +
    '<body>' +
    '<h1>Following paths are defined:</h1>' +
    '<ul>' +
    '<li><a href="http://localhost:1380/home">/home</a></li>' +
    '<li><a href="http://localhost:1380/start">/start</a></li>' +
    '<li><a href="http://localhost:1380/find">/find</a></li>' +
    '<li><a href="http://localhost:1380/upload">/upload</a></li>' +
    '<li><a href="http://localhost:1380/show">/show</a></li>' +
    '<li><a href="http://localhost:1380/load">/load</a></li>' +
    '</ul>' +
    '</body>' +
    '</html>';
  answerHtml response, 200, content

exports.start = (request, response, postData) ->
  console.log 'Handling start.'
  content = '<html>' +
    '<head>' +
    '<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />' +
    '</head>' +
    '<body>' +
    '<form action="/upload" method="post">' +
    '<table>' +        
    '<tr><td>Title:</td><td><input type="text" name="title"></td></tr>' +
    '<tr><td>Description:</td><td><textarea name="description" rows="20" cols="60"></textarea></td></tr>' +
    '<tr><td>File:</td><td><input type="file" name="upload" multiple="multiple" /></td></tr>' +
    '<tr><td></td><td><input type="submit" value="Save" /></td></tr>' + 
    '</table>'
    '</form>' + 
    '</body>' +
    '</html>';
  answerHtml response, 200, content

exports.find = (request, response, postData) ->
  console.log 'Handling find.'
  exec 'find /', 
  {timeout: 10000, maxBuffer: 20000 * 1024}, 
  (error, stdout, stderr) ->
    answerPlainText response, 200, stdout

exports.upload = (request, response, postData) ->
  console.log 'Handling upload.'
  if request.method.toLowerCase() == 'post'
    answerPlainText response, 200, postData
  else
    answerPlainText response, 200, 'This wasn\'t a POST request!'

exports.show = (request, response, postData) ->
  console.log 'Handling show.'
  fs.readFile '/temp/test.png', 'binary', (error, file) ->
    if error
      answerPlainText response, 200, 'Error while reading file "/tmp/test.png"'
    else
      response.writeHead code, {'Content-Type': 'image/png'}
      response.write file, 'binary'
      response.end          

exports.load = (request, response, postData) ->
  console.log 'Handling load.'
  fs.readFile 'html/index.html', 'utf-8', (error, file) ->
    answerHtml response, 200, file

exports.defaultHandler = (request, response, postData) ->
  console.log 'Handling parse.'
  parsedUrl = url.parse request.url
  if parsedUrl
    console.log parsedUrl
    answerPlainText response, 200, parsedUrl