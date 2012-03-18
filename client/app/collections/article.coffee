Article = require("models/article").Article

class exports.ArticleCollection extends Backbone.Collection

  model: Article
  url: '/categories/articles/'

  constructor: (category) ->
    super()
    @url = "/categories/#{category.slug}/articles/"

  # Select which field from backend response to use for parsing to populate
  # collection.
  parse: (response) ->
    response.rows

