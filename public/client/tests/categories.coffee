describe 'Category browsing', ->

  it 'Add Category jasmine', ->
    waitsFor(
      -> $("#category-field").length > 0
      "Page did not get loaded",
      2000
    )
    runs ->
      $("#category-field").val("Category Jasmine")
      $("#category-add-submit").click()
    waits(500)
    runs ->
      expect($("#category-jasmine").length).not.toEqual(0)

  it 'Displays Category jasmine', ->
    runs ->
      $("#category-jasmine").click()
    waits(500)
    runs ->
      expect($("#back-categories").length).not.toEqual(0)

  it 'Goes back to category list', ->
    runs ->
      $("#back-categories").click()
      window.location.href = $("#back-categories").attr("href")
    waits(500)
    runs ->
      expect($("#category-list").length).not.toEqual(0)


describe 'Category deletion', ->

  it 'When I display newly created category', ->
    runs ->
      $("#category-jasmine").click()
    waits(500) # Waits to be sure that everything is done before testing

  it 'And I click on delete category button from a category page', ->
    runs ->
      $("#delete-category-button").click()
    waits(500) # Waits to be sure that everything is done before testing

  it 'Then it brings me back to category list', ->
    runs ->
      expect($("#category-list").length).not.toEqual 0

  it 'And deleted activity is no more in the list', ->
    runs ->
      expect($("#category-jamsine").length).toEqual 0



