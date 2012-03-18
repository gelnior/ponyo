### Application entry point ###

window.app = {}
app.routers = {}
app.models = {}
app.collections = {}
app.views = {}

MainRouter = require('routers/main_router').MainRouter
HomeView = require('views/home_view').HomeView
CategoryView = require('views/category_view').CategoryView
ArticleView = require('views/article_view').ArticleView

# app bootstrapping on document ready
$(document).ready ->
  app.initialize = ->

    # Routers
    app.routers.main = new MainRouter()
 
    # Views
    app.views.home = new HomeView()
    app.views.category = new CategoryView()
    app.views.article = new ArticleView()

  app.start = ->
    # Initialize app route 
    app.routers.main.navigate 'home', true if Backbone.history.getFragment() is ''
  
  app.initialize()
  Backbone.history.start
    root: "/"
  app.start()

