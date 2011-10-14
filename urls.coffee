module.exports = (app) ->
  routers = require('./controllers/controllers')
  
  app.get "/", routers.index
  app.post "/categories/", routers.newCategory
  app.get "/categories/:category/", routers.category

