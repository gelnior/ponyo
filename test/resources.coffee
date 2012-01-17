process.env.TZ = 'UTC'

http = require('http')
request = require('request')
vows = require('vows')
eyes = require('eyes')
assert = require('assert')
time = require('time')(Date)
moment = require('moment')

CategoryProvider = require("../models/models").CategoryProvider
ArticleProvider = require("../models/models").ArticleProvider
Category = require("../models/models").Category

rootUrl = "http://localhost:3000/"
cookie = null


# Client
apiTest =
  general: (method, url, data, callback) ->
    request {
        method: method,
        url: rootUrl + (url || ''),
        json: data || {},
        headers: { Cookie: cookie }
      },
      callback
    return

  get: (url, callback) -> apiTest.general 'GET', url, {}, callback
  post: (url, data, callback) -> apiTest.general 'POST', url, data, callback
  put: (url, data, callback) -> apiTest.general 'PUT', url, data, callback
  del: (url, callback) -> apiTest.general 'DELETE', url, {}, callback


# Macros

assertStatus = (code) ->
  (error, response, body) ->
    assert.notEqual undefined, response
    assert.equal response.statusCode, code
    assert.ok response.body

assertJSONHead = ->
  (error, response, body) ->
    assert.equal response.headers['content-type'], \
                 'application/json; charset=utf-8'


# Tests

vows.describe('Resources')


# Categories

  .addBatch
    'A category provider':
      topic: () ->
        new CategoryProvider

      'delete all categories':
        topic: (categoryProvider) ->
           categoryProvider.deleteAll @callback
  
        'without any error': (err) ->
           assert.isUndefined err.stack
  

  .addBatch
    'A category provider':
      topic: () ->
        new CategoryProvider

      'creates a new category':
        topic: (categoryProvider) ->
          categoryProvider.newCategory "Category 01", @callback

        'that has now an id': (doc) ->
          assert.isNotNull doc._id
  

  .addBatch
    'GET /':
      topic: () ->
        apiTest.get '', @callback

      'response should be with a 200 OK': (error, response, body) ->
         assertStatus 200
         assert.ok response.body
  

  .addBatch
    'GET /categories/':
      topic: () ->
        apiTest.get 'categories/', @callback

      'response should be with a 200 OK': assertStatus 200
      'response should contains one category': (error, response, body) ->
         docs = body.rows
         assert.equal 1, docs.length
         assert.equal "Category 01", docs[0].name
  
  
  .addBatch
    'GET /categories/category-01/':
      topic: () ->
        apiTest.get 'categories/category-01/', @callback

      'response should be with a 200 OK': assertStatus 200
      'response should contains one category': (error, response, body) ->
         assert.equal "Category 01", body.name
  

  .addBatch
    'GET /categories/category-02/':
      topic: () ->
        apiTest.get 'categories/category-02/', @callback
      'response should be with a 404 not found':assertStatus 404
  

  .addBatch
    'POST /categories/':
      topic: () ->
        apiTest.post 'categories/', name: "Category 02", @callback
      'response should be with a 200 OK':assertStatus 200
      'respond body should tell that creation succeeds':
        (error, response, body) ->
          assert.ok body.success
  

  .addBatch
    'GET /categories/category-02/':
      topic: () ->
        apiTest.get 'categories/category-02/', @callback

      'response should be with a 200 OK': assertStatus 200
      'response should contains one category': (error, response, body) ->
         assert.equal "Category 02", body.name
  

  .addBatch
    'DELETE /categories/category-02/':
      topic: () ->
        apiTest.del 'categories/category-02/', @callback

      'response should be with a 200 OK': assertStatus 200
      'GET /categories/category-02/':
         topic: () ->
           apiTest.get 'categories/category-02/', @callback
         'response should be with a 404 Not Found': assertStatus 404
      'DELETE /categories/category-02/':
         topic: () ->
           apiTest.del 'categories/category-02/', @callback
         'response should be with a 404 Not Found': assertStatus 404

# Articles

  .addBatch
    'An article provider':
      topic: () ->
        new ArticleProvider

      'deletes all articles':
        topic: (articleProvider) ->
           articleProvider.deleteAll @callback
  
        'without any error': (err) ->
           assert.isUndefined err.stack
  

  .addBatch
    'An article provider':
      topic: () ->
        new ArticleProvider

      'creates a new article':
        topic: (articleProvider) ->
          category = new Category name: "Category 01", slug: "category-01"

          date = new Date(2012, 0, 5, 0, 0, 0, 0)
          articleProvider.newArticle category, "Article 01", date, @callback

        'that has now an id': (doc) ->
          assert.notEqual undefined, doc
          assert.isNotNull doc._id
  

  .addBatch
    'GET /categories/category-01/articles/':
      topic: () ->
        apiTest.get 'categories/category-01/articles/', @callback

      'response should be with a 200 OK': assertStatus 200
      'response should contains one article': (error, response, body) ->
         assert.notEqual undefined, body

         docs = body.rows
         assert.notEqual undefined, docs

         assert.equal 1, docs.length
         assert.equal "Article 01", docs[0].name

  .addBatch
    'GET /categories/category-01/articles/2012/01/05/article-01/':
      topic: () ->
        apiTest.get 'categories/category-01/articles/2012/01/05/article-01/', \
          @callback

      'response should be with a 200 OK': assertStatus 200
      'response should contains one article': (error, response, body) ->
        assert.equal body.name, "Article 01"

  .addBatch
    'POST /categories/category-01/articles/':
      topic: () ->
        apiTest.post 'categories/category-01/articles/', \
          name: "Article 02", @callback
      'response should be with a 200 OK':assertStatus 200
      'respond body should tell that creation succeeds':
        (error, response, body) ->
          assert.ok body.success

  .addBatch
    'GET /categories/category-01/articles/yyyy/mm/dd/article-02/':
      topic: () ->
        date = new time.Date()
        date.setTimezone("UTC")
        date.setMinutes(0)
        date.setHours(0)
        date.setSeconds(0)
        date.setMilliseconds(0)
        url = 'categories/category-01/articles/'
        url += moment(date).format("YYYY/MM/DD/")
        url += 'article-02/'

        apiTest.get url, @callback

      'response should be with a 200 OK': assertStatus 200
      'response should contains one article': (error, response, body) ->
        assert.equal body.name, "Article 02"

  .export(module)

