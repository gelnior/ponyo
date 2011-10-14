class Category extends Backbone.Model

  url: '/categories/'

  constructor: (category) ->
    super()

    @id = category.slug


class CategoryCollection extends Backbone.Collection

  model: Category
  url: '/categories/'

  # Select which field from backend response to use for parsing to populate
  # collection.
  parse: (response) ->
    response.rows

