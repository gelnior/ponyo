module.exports = (app) ->
  routers = require('./controllers/controllers')

  # Home  
  app.get "/", routers.index
  app.get "/tests/", routers.indexTest

  # Categories
  app.get "/categories/", routers.getCategories
  app.post "/categories/", routers.newCategory
  app.get "/categories/:category/", routers.category
  app.del "/categories/:category/", routers.deleteCategory

  # Article
  app.get "/categories/:category/articles/", routers.getArticles
  app.post "/categories/:category/articles/", routers.newArticle
  app.get "/categories/:category/articles/:year/:month/:day/:article", \
      routers.getArticle


