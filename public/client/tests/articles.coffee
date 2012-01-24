describe 'Article creation', ->

  it 'Given I browse a category', ->
    runs ->
      $("#category-field").val("Category Jasmine")
      $("#category-add-submit").click()
    waits(300)
    runs ->
      $("#category-jasmine").click()
    waits(300)

  it 'When I fill the new article title field', ->
    runs ->
      $("#article-field").val("Article Jasmine")

  it 'And I click on add button', ->
    runs ->
      $("#article-add-submit").click()
    waits(500)

  it 'Then a new article with given title and actual date is displayed', ->
    runs ->
      date = moment().format("YYYY-MM-DD-")
      expect($("##{date}article-jasmine").length).not.toEqual(0)


describe 'Article browsing', ->

  it 'When I click on an article', ->
    runs ->
      date = moment().format("YYYY-MM-DD-")
      $("##{date}article-jasmine").click()
    waits(300)

  it 'Then I display the article page', ->
    runs ->
      expect($(".article-title").length).not.toEqual(0)

