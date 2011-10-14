express = require("express")


# Configuration
app = module.exports = express.createServer()
app.configure ->
  app.set "views", __dirname + "/views"
  app.register '.coffee', require('coffeekup')
  app.set 'view engine', 'coffee'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use require("stylus").middleware(src: __dirname + "/public")
  app.use app.router
  app.use express.static(__dirname + "/public")


app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()


# Routes
require('./urls')(app)


# Start
app.listen 3000
console.log "Ponyo listening on port %d in %s mode",\
            app.address().port, app.settings.env

