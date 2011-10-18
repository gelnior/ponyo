module.exports = (app) ->
  routers = require('./controllers/controllers')

  # Home  
  app.get "/", routers.index

  # Categories
  app.get "/categories/", routers.getCategories
  app.post "/categories/", routers.newCategory
  app.get "/categories/:category/", routers.category

