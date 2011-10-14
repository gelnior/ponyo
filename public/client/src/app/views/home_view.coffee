require("utils/string")
categoryTemplate = require('templates/categories')
CategoryCollection = require('models/category').CategoryCollection
CategoryRow = require('views/category').CategoryRow

class exports.HomeView extends Backbone.View
  id: 'home-view'

  ### Events ###

  events:
    "click #category-add-submit": "onAddCategoryClicked"
    "click .category-name": "onCategoryNameClicked"

  constructor: ->
    super()

    @categories = new CategoryCollection()
   
  ### Listeners ###

  onAddCategoryClicked: (event) =>
    categoryName = $("#category-field").val()

    $.ajax
      type: 'POST'
      url: "categories/"
      data: { name: categoryName }
      success: () ->
        $("#category-list").append("<li>#{categoryName}</li>")
        $(".category-name").click(@onCategoryNameClicked)

      dataType: "json"

  onCategoryNameClicked: (event) ->
    name = $(event.target).html()
    $.get "/categories/#{name.slugify()}/", (data) ->
      $("#nav-content").html(data)
    
  onCategoriesAdded: () ->
    categories.forEach (category) ->
      categoryRow = new CategoryRow
      $("category-list").append categoryRow.render()

  setListeners: ->
    $("#category-add-submit").click(@onAddCategoryClicked)
    $(".category-name").click(@onCategoryNameClicked)

    @categories.bind("addAll", onCategoriesAdded)
  
  render: ->
    $("#nav-content").html(categoryTemplate())
    
    @categories.fetch()


