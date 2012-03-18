articleTemplate = require('templates/article')

class exports.ArticleRow extends Backbone.View

  tagName: "li"
  className: "article-row"

  constructor: (@model) ->
    super()
    
    @id = @model.slug
    @model.view = @

  events:
    "click": "onClicked"


  onClicked: (event) ->
    app.routers.main.navigate \
        "categories/#{@model.categorySlug}/articles#{@model.path}", true

  remove: ->
    $(@el).remove()

  render: ->
    $(@el).html(articleTemplate(article: @model))
    @el
