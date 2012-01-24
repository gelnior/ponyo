categoryViewTemplate = require('../templates/category_view')
Category = require('../models/category').Category


articleTemplate = require('templates/article')
Article = require('models/article').Article
ArticleRow = require('views/article').ArticleRow
ArticleCollection = require('collections/article').ArticleCollection

class exports.CategoryView extends Backbone.View
  id: 'category-view'

  events:
    "click #delete-category-button": "onDeleteButtonClicked"
    "click #article-add-submti": "onAddArticleClicked"

  ### Events ###


  ### Constructor ###

  constructor: ->
    super()
    

  ### Listeners ###

  setListeners: =>
    @deleteButton.click(@onDeleteButtonClicked)
    $("#article-add-submit").click(@onAddArticleClicked)

  onAddArticleClicked: (event) =>
    articleName = @articleField.val()

    $.ajax(
      type: 'POST',
      url: @articles.url,
      data: { name: articleName },
      success: =>
        date = new Date()
        date.setHours(0)
        date.setMinutes(0)
        date.setSeconds(0)
        article = new Article
          "name": articleName
          "slug": articleName.slugify()
          "date": date

        @addArticleToArticleList article
      ,
      dataType: "json",
    )

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
    @articles.forEach @addArticleToArticleList

  # From an article model build the category widget to display inside 
  # category list.
  addArticleToArticleList: (article) =>
    articleRow = new ArticleRow article
    el = articleRow.render()
    @articleList.append el
    el.id = article.dateSlug

  ### Functions ###

  render: (category) ->
    $("#nav-content").html null

    $.get "/categories/#{category}/", (data) =>
      $("#nav-content").html categoryViewTemplate(category: data)
      @model = new Category data

      @deleteButton = $("#delete-category-button")
      @addButton = $("#article-add-submit")
      @articleField = $("#article-field")
      @articleList = $("#article-list")

      @setListeners()
      
      @articles = new ArticleCollection(data)
      @articles.bind('reset', @fillArticles)
      @articles.fetch()

