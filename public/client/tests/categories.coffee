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
      expect(false).toBeTruthy()

  it 'And I click on delete category button from a category page', ->
      expect(false).toBeTruthy()

  it 'Then it brings me back to category list', ->
      expect(false).toBeTruthy()

  it 'And deleted activity is no more in the list', ->
      expect(false).toBeTruthy()



