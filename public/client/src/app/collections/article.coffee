Article = require("models/article").Category

class exports.ArticleCollection extends Backbone.Collection

  model: Article
  url: '/articles/'

  constructor: () ->
    super()

  # Select which field from backend response to use for parsing to populate
  # collection.
  parse: (response) ->
    response.rows

