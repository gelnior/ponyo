categoryViewTemplate = require('../templates/category_view')
Category = require('../models/category').Category


articleTemplate = require('templates/article')
CategoryRow = require('views/category').CategoryRow
CategoryCollection = require('collections/category').CategoryCollection

class exports.CategoryView extends Backbone.View
  id: 'category-view'

  events:
    "click #delete-category-button": "onDeleteButtonClicked"

  ### Events ###


  ### Constructor ###

  constructor: ->
    super()

    @articles = new ArticleCollection()

  ### Listeners ###

  setListeners: =>
    @articlees.bind('reset', @fillArticles)
    @addButton.click(@onAddArticleClicked)


  onDeleteButtonClicked : (event) =>
    event.preventDefault()
    
    @model.destroy
      success: ->
        app.routers.main.navigate("home", true)
      error: ->
        alert "An error occured, category was probably not deleted."
 

  ### Functions ###

  render: (category) ->
    $("#nav-content").html null
    $.get "/categories/#{category}/", (data) =>
      $("#nav-content").html categoryViewTemplate(category: data)
      @model = new Category data

      @deleteButton = $("#delete-category-button")
      @deleteButton.click(@onDeleteButtonClicked)

      @articles.fetch()

