div id:"home-view", ->
  h1 ->
    @title

  if @test
    h3 ->
      "Test"

  div id:"nav-content", ->

script ->
  "require('main');"

if @test
  script src: '/client/tests/categories.js'
  script src: '/client/tests/articles.js'
  script '''
        jasmine.getEnv().addReporter(new jasmine.TrivialReporter())
        jasmine.getEnv().execute()
      '''
