categoryViewTemplate = require('../templates/category_view')
Category = require('../models/category').Category

class exports.CategoryView extends Backbone.View
  id: 'category-view'

  events:
    "click #delete-category-button": "onDeleteButtonClicked"

  ### Events ###

  constructor: ->
    super()

  render: (category) ->
    $("#nav-content").html null
    $.get "/categories/#{category}/", (data) =>
      $("#nav-content").html categoryViewTemplate(category: data)
      @model = new Category data

      @deleteButton = $("#delete-category-button")
      @deleteButton.click(@onDeleteButtonClicked)

  onDeleteButtonClicked : (event) =>
    event.preventDefault()
    
    @model.destroy
      success: ->
        app.routers.main.navigate("home", true)
      error: ->
        alert "An error occured, category was probably not deleted."
        app.routers.main.navigate("home", true)
