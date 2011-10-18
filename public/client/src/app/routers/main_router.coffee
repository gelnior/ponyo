class exports.MainRouter extends Backbone.Router
  routes :
    "home": "home"
    "categories/:category": "category"

  home: ->
    app.views.home.render()

  category: (category) ->
    app.views.category.render(category)

