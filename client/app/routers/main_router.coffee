class exports.MainRouter extends Backbone.Router
  routes :
    "home": "home"
    "categories/:category": "category"
    "categories/:category/articles/:year/:month/:day/:article/": "article"

  home: ->
    app.views.home.render()

  category: (category) ->
    app.views.category.render(category)

  article: (category, year, month, day, article) ->
    app.views.article.render(category, year, month, day, article)

