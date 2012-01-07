describe 'Article creation', ->

  it 'Given I browse a category', ->
    runs ->
      if $("#category-jasmine").length == 0
        $("#category-field").val("Category Jasmine")
        $("#category-add-submit").click()
        waits(300)
      $("#category-jasmine").click()

  it 'When I fill the new article title field', ->
    runs ->
      $("#article-field").val("Article Jasmine")

  it 'And I click on add button', ->
    runs ->
      $("#article-add-submit").click()
      expect(false).toBeTruthy()
    waits(500)

  it 'Then a new article with given title is displayed', ->
    runs ->
      expect($("#article-jasmine").length).not.toEqual(0)


describe 'Article browsing', ->

  it 'When I click on an article', ->
    $("#article-jasmine").click()

  it 'Then I display the article page', ->
    runs ->
      expect($("#article-jasmine-title").length).not.toEqual(0)

