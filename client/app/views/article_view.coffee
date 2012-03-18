articleViewTemplate = require('../templates/article_view')
Article = require('../models/article').Article


class exports.ArticleView extends Backbone.View
  id: 'article-view'

  events:
    "click #delete-article-button": "onDeleteButtonClicked"

  ### Events ###


  ### Constructor ###

  constructor: ->
    super()
    

  ### Listeners ###

  setListeners: =>
    @deleteButton.click(@onDeleteButtonClicked)

  onDeleteButtonClicked : (event) =>
    event.preventDefault()
    
    @model.destroy
      success: ->
        app.routers.main.navigate("categories/#{@model.categorySlug}", true)
      error: ->
        alert "An error occured, category was probably not deleted."

  ### Functions ###

  render: (category, year, month, day, article) ->
    $("#nav-content").html null

    $.get "/categories/#{category}/articles/" + \
          "#{year}/#{month}/#{day}/#{article}", (data) =>
      @model = new Article data
      $("#nav-content").html articleViewTemplate(article: @model)

      @deleteButton = $("#delete-category-button")
      @setListeners()
      
