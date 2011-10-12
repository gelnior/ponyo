express = require("express")
mongoose = require('mongoose')

# DB
mongoose.connect('mongodb://127.0.0.1/ponyo')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

# Models
extraField = new Schema name : String, type : String

categorySchema = new Schema
  name : String
  slug : type : String, lowercase : true
  extraFields : [extraField]

Category = mongoose.model('Category', categorySchema)

class CategoryProvider
  getAll: (callback) ->
    query = Category.find({})
    query.exec(callback)
categoryProvider = new CategoryProvider


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

app.get "/", (req, res) ->
  categoryProvider.getAll (err, docs) ->
    if err
       console.error(err.stack)
       docs = []
    res.render "index", title: "Ponyo", categories: docs

app.post "/categories/", (req, res) ->
  name = req.body.name

  if name
    category = new Category name: name
    category.save (err) ->
      if err
        console.error(err.stack)
        return res.json  success: false
      else
        return res.json  success: true
  else
    return res.json success: false

# Start
app.listen 3000
console.log "Ponyo listening on port %d in %s mode",\
            app.address().port, app.settings.env
