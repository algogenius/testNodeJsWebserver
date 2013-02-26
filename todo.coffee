var http = require('http');
var fs = require('fs');
var url = require('url');
var path = require('path');
var Extensions = require('./extensions.js').Extensions;
 
var Server = "Not Initialised";
exports.ServerStatus = function(){ return Server; };
 
exports.CreateServer = function(Port, Folders){
    http.createServer(function(req, res){
    var filepath = "html" + url.parse(req.url).pathname;
    if(filepath == "html/" )
    {
        filepath += "index.html";
    }
    var Access = false;
    var RequestedFolder = path.dirname(filepath);
    for(var Dir in Folders)
    {
        if(Folders[Dir] == RequestedFolder)
        {
            Access = true;
        }
    }
    if(Access)
    {
        path.exists(filepath, function(exists){
            if(exists)
            {
                fs.readFile(filepath, "binary", function(err, data){
                    if(err)
                    {
                        res.writeHead(500, { 'content-type' : 'text/html' });
                        res.end("There Was A Server Error While Reading The File");
                    }
                    else
                    {
                        if(Extensions.hasOwnProperty(path.extname(filepath)))
                        {
                            Extensions[path.extname(filepath)](data, res);
                        }
                        else
                        {
                            res.writeHead(501, { 'content-type' : 'text/html' });
                            res.end("That Filetype Has Not Been Implemented On The Server");
                        }
                    }
                });
            }
            else
            {
                res.writeHead(404, { 'content-type' : 'text/html' });
                res.end("The File You Are Trying To Access Does Not Exist");
            }
        });
    }
    else
    {
        res.writeHead(403, { 'content-type' : 'text/html' });
        res.end("The File You Are Trying To Access Is Private");
    }
    }).listen(Port);
    Server = "Started";
}




function html(data, res){
  res.writeHead(200, { 'content-type' : 'text/html' });
  res.end(data, "binary");
}
 
function css(data, res){
  res.writeHead(200, { 'content-type' : 'text/css' });
  res.end(data, "binary");
}
 
function png(data, res){
  res.writeHead(200, { 'content-type' : 'image/png' });
  res.end(data, "binary");
}
 
function gif(data, res){
  res.writeHead(200, { 'content-type' : 'image/gif' });
  res.end(data, "binary");
}
 
function jpg(data, res){
  res.writeHead(200, { 'content-type' : 'image/jpeg' });
  res.end(data, "binary");
}
 
function hash(data, res){
  res.writeHead(200, { 'content-type' : 'text/html' });
  var Temp = data.toString("binary");
  var Template = /#([0-9a-zA-Z]+)/;
  var Search = Template.exec(Temp);
  var Info = {
    "Name" : "John Smith"
  };
  while(Search != null)
  {
      Temp = Temp.replace(Search[0], Info[Search[1]]);
      Search = Template.exec(Temp);
  }
  res.end(Temp);
}
 
function ico(data, res){
  res.writeHead(200, { 'content-type' : 'image/x-icon' });
  res.end(data, "binary");
}
 
var Extentions = {
  ".html" : html,
  ".htm" : html,
  ".png" : png,
  ".gif" : gif,
  ".hash" : hash,
  ".ico" : ico,
  ".jpg" : jpg,
  ".css" : css
}
 
exports.Extensions = Extentions;