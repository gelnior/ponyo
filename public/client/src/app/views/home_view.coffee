require("utils/string")

categoryTemplate = require('templates/categories')
CategoryRow = require('views/category').CategoryRow
CategoryCollection = require('collections/category').CategoryCollection


# Main view : display category list. Allows to create a new category and 
# access to details for a given category.
class exports.HomeView extends Backbone.View
  id: 'home-view'


  ### Events ###

  events:
    "click #category-add-submit": "onAddCategoryClicked"


  ### Constructor ###

  constructor: ->
    super()

    @categories = new CategoryCollection()
  
 
  ### Listeners ###

  setListeners: =>
    @categories.bind('reset', @fillCategories)
    @addButton.click(@onAddCategoryClicked)

  # When add button is clicked, category name is grabbed for category
  # name field, then a new category is created for this field.
  onAddCategoryClicked: (event) =>
    categoryName = @categoryField .val()

    $.ajax
      type: 'POST'
      url: "categories/"
      data: { name: categoryName }
      success: =>
        @categoryList.append("<li>#{categoryName}</li>")

      dataType: "json"


  ### Functions ###

  # Grabs categories from server then display them as a list.
  fillCategories: () =>
    @categoryList.html null
    @categories.forEach (category) =>
      categoryRow = new CategoryRow category
      @categoryList.append categoryRow.render()
 

  ### Render ###
  
  # Displays templates and register widgets. 
  render: ->
    @content = $("#nav-content")
    @content.html categoryTemplate()

    @categoryList = $("#category-list")
    @categoryField = $("#category-field")
    @addButton = $("#category-add-submit")
    @setListeners()

    @categoryList.html(null)
    @categories.fetch()


