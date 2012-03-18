class exports.Category extends Backbone.Model

  url: '/categories/'

  constructor: (category) ->
    super()
    
    @name = category.name
    @slug = category.slug
    @id = category.slug

    @url += @id + "/"

  isNew: () ->
    @id is undefined
