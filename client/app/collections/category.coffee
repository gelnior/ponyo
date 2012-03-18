Category = require("models/category").Category

class exports.CategoryCollection extends Backbone.Collection

  model: Category
  url: '/categories/'

  constructor: () ->
    super()

  # Select which field from backend response to use for parsing to populate
  # collection.
  parse: (response) ->
    response.rows

