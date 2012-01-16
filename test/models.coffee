vows = require('vows')
eyes = require('eyes')
assert = require('assert')
time = require('time')(Date)

CategoryProvider = require("../models/models").CategoryProvider
ArticleProvider = require("../models/models").ArticleProvider

Category = require("../models/models").Category


vows.describe('Categories and articles')

  .addBatch(
    'A category provider':
      topic: () ->
        new CategoryProvider

      'delete all categories':
        topic: (categoryProvider) ->
           categoryProvider.deleteAll @callback
  
        'without any error': (err) ->
           assert.isUndefined err.stack
  )

  .addBatch(
    'A category provider':
      topic: () ->
        new CategoryProvider

      'creates a new category':
        topic: (categoryProvider) ->
          categoryProvider.newCategory "Category 01", @callback

        'that has now an id': (doc) ->
          assert.isNotNull doc._id
  )

  .addBatch(
    'A category provider':
      topic: () ->
        new CategoryProvider

      'gets the new category':
        topic: (categoryProvider) ->
          categoryProvider.getCategory "category-01", @callback

        'that returns only one document': (err, docs) ->
          assert.equal 1, docs.length
          
        'with right name and right slug': (err, docs) ->
          category = docs[0]
          assert.notEqual category, undefined
          assert.equal "Category 01", category.name
          assert.equal "category-01", category.slug
  )


  .addBatch(
    'A category provider':
      topic: () ->
        new CategoryProvider

      'gets all category':
        topic: (categoryProvider) ->
          categoryProvider.getAll @callback

        'and find one category': (docs) ->
          assert.equal 1, docs.length
  )


  .addBatch(
    'An article provider':
      topic: () ->
        new ArticleProvider

      'deletes all articles':
        topic: (articleProvider) ->
           articleProvider.deleteAll @callback
  
        'without any error': (err) ->
           assert.isUndefined err.stack
  )

 .addBatch(
    'An article provider':
      topic: () ->
        new ArticleProvider

      'creates a new article for category 01':
        topic: (articleProvider) ->
          cat = new Category name: "Category 01", slug: "category-01"
         
          date = new time.Date()
          date.setTimezone("UTC")
          date.setMinutes(0)
          date.setHours(0)
          date.setSeconds(0)
          date.setMilliseconds(0)
          articleProvider.newArticle cat, "Article 01", date, @callback
 
        'that has now an id': (doc) ->
            assert.notEqual undefined, doc
            assert.isNotNull doc._id
  )

  .addBatch(
    'An article provider':
      topic: () ->
        new ArticleProvider

      'gets all article for category 01':
        topic: (articleProvider) ->
          cat = new Category name: "Category 01", slug: "category-01"
          articleProvider.getAll cat, @callback

        'and find one article': (docs) ->
          assert.equal 1, docs.length
  )


  .addBatch(
    'An article provider':
      topic: () ->
        new ArticleProvider

      'gets a given article for category 01':
        topic: (articleProvider) ->
          date = new time.Date()
          date.setTimezone("UTC")
          date.setMinutes(0)
          date.setHours(0)
          date.setSeconds(0)
          date.setMilliseconds(0)
          cat = new Category name: "Category 01", slug: "category-01"
          articleProvider.getArticle cat, date, "article-01", @callback

        'and find corresponding article': (docs) ->
          assert.equal docs[0].slug, "article-01"
  )

  .export(module)

