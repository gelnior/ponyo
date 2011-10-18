categoryViewTemplate = require('../templates/category_view')

class exports.CategoryView extends Backbone.View
  id: 'category-view'

  ### Events ###

  constructor: ->
    super()

  render: (category) ->
    $("#nav-content").html null
    $.get "/categories/#{category}/", (data) ->
      $("#nav-content").html categoryViewTemplate(category: data)


