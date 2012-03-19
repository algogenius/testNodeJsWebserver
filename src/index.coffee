httpd = require './httpd'
router = require './router'
requestHandlers = require './requestHandlers'

handle = {}
handle['/'] = requestHandlers.home
handle['/home'] = requestHandlers.home
handle['/start'] = requestHandlers.start
handle['/find'] = requestHandlers.find
handle['/upload'] = requestHandlers.upload
handle['/show'] = requestHandlers.show
handle['/load'] = requestHandlers.load
handle['defaultHandler'] = requestHandlers.defaultHandler

httpd.run router.route, handle