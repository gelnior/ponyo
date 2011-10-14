div id:"home-view", ->
  h1 ->
    @title

  p ->
    "Add a category"
  p ->
    input id:"category-field", type:"text"
    input id:"category-add-submit", type:"submit"

  ul id:"category-list", ->
    for category in @categories
      li ->
        category.name

script ->
  "require('main');"

