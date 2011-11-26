vows = require('vows')
eyes = require('eyes')
assert = require('assert')
CategoryProvider = require("../models/models").CategoryProvider


vows.describe('Categories')

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
          assert.equal docs.length, 1
          
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



  .export(module)


