categoryTemplate = require('templates/category')

class exports.CategoryRow extends Backbone.View

  tagName: "li"
  className: "category-row"

  constructor: (@model) ->
    super()
    
    @id = @model.slug
    @model.view = @

  events:
    "click": "onClicked"


  onClicked: (event) ->
    app.routers.main.navigate "categories/#{@model.slug}", true

  remove: ->
    $(@el).remove()

  render: ->
    $(@el).html(categoryTemplate(category: @model))
    @el
