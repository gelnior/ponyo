class exports.MainRouter extends Backbone.Router
  routes :
    "home": "home"
    "categories/:category": "category"
    "categories/:category/articles/:article": "article"

  home: ->
    app.views.home.render()

  category: (category) ->
    app.views.category.render(category)

  category: (category, article) ->
    app.views.category.render(category, article)

