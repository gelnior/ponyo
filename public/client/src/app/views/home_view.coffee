homeTemplate = require('templates/home')

class exports.HomeView extends Backbone.View
  id: 'home-view'

  ### Events ###

  events:
    "click #category-add-submit": "onAddCategoryClicked"

  constructor: ->
    super()
   
  ### Listeners ###

  onAddCategoryClicked: (event) =>
    categoryName = $("#category-field").val()

    $.ajax
      type: 'POST'
      url: "categories/"
      data: { name: categoryName }
      success: () ->
        $("#category-list").append("<li>#{categoryName}</li>")
      dataType: "json"

  setListeners: ->
    $("#category-add-submit").click(@onAddCategoryClicked)
  
  render: ->
    @


