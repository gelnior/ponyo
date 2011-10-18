### Application entry point ###

window.app = {}
app.routers = {}
app.models = {}
app.collections = {}
app.views = {}

MainRouter = require('routers/main_router').MainRouter
HomeView = require('views/home_view').HomeView
CategoryView = require('views/category_view').CategoryView

# app bootstrapping on document ready
$(document).ready ->
  app.initialize = ->

    # Routers
    app.routers.main = new MainRouter()
 
    # Views
    app.views.home = new HomeView()
    app.views.category = new CategoryView()

    # Initialize app route 
    app.routers.main.navigate 'home', true if Backbone.history.getFragment() is ''
  app.initialize()
  Backbone.history.start()

