categoryViewTemplate = require('../templates/category_view')
Category = require('../models/category').Category


articleTemplate = require('templates/article')
ArticleRow = require('views/article').ArticleRow
ArticleCollection = require('collections/article').ArticleCollection

class exports.CategoryView extends Backbone.View
  id: 'category-view'

  events:
    "click #delete-category-button": "onDeleteButtonClicked"

  ### Events ###


  ### Constructor ###

  constructor: ->
    super()


  ### Listeners ###

  setListeners: =>
    @addButton.click(@onAddArticleClicked)


  onDeleteButtonClicked : (event) =>
    event.preventDefault()
    
    @model.destroy
      success: ->
        app.routers.main.navigate("home", true)
      error: ->
        alert "An error occured, category was probably not deleted."

  # Display articles grabbed from server as a list.
  fillArticles: =>
    @articleList.html null
    @articles.forEach (article) =>
      articleRow = new ArticleRow article
      el = articleRow.render()
      @articleList.append el
      el.id = article.slug

  ### Functions ###

  render: (category) ->
    $("#nav-content").html null

    $.get "/categories/#{category}/", (data) =>
      $("#nav-content").html categoryViewTemplate(category: data)
      @model = new Category data

      @deleteButton = $("#delete-category-button")
      @deleteButton.click(@onDeleteButtonClicked)

      @articleList = $("#article-list")

      @articles = new ArticleCollection(data)
      @articles.bind('reset', @fillArticles)
      @articles.fetch()

