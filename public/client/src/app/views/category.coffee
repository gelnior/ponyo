categoryTemplate = require('templates/category')

class CategoryRow extends Backbone.View

  tagName: "li"
  className: "category-row"

  constructor: (@model) ->
    super()

    @id = @model.id
    @model.view = @

  remove: ->
    $(@el).remove()

  render: ->
    $(@el).html(categoryTemplate(category: @model))
