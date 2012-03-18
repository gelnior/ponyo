(function() {
  var ArticleProvider, Category, CategoryProvider, assert, cat, eyes, time, vows;

  vows = require('vows');

  eyes = require('eyes');

  assert = require('assert');

  time = require('time')(Date);

  CategoryProvider = require("../models/models").CategoryProvider;

  ArticleProvider = require("../models/models").ArticleProvider;

  Category = require("../models/models").Category;

  cat = new Category({
    name: "Category 01",
    slug: "category-01"
  });

  vows.describe('Categories and articles').addBatch({
    'A category provider': {
      topic: function() {
        return new CategoryProvider;
      },
      'deletes all categories': {
        topic: function(categoryProvider) {
          return categoryProvider.deleteAll(this.callback);
        },
        'without any error': function(err) {
          return assert.isUndefined(err.stack);
        }
      }
    }
  }).addBatch({
    'A category provider': {
      topic: function() {
        return new CategoryProvider;
      },
      'creates a new category': {
        topic: function(categoryProvider) {
          return categoryProvider.newCategory("Category 01", this.callback);
        },
        'that has now an id': function(doc) {
          return assert.isNotNull(doc._id);
        }
      }
    }
  }).addBatch({
    'A category provider': {
      topic: function() {
        return new CategoryProvider;
      },
      'gets the new category': {
        topic: function(categoryProvider) {
          return categoryProvider.getCategory("category-01", this.callback);
        },
        'that returns only one document': function(err, docs) {
          return assert.equal(1, docs.length);
        },
        'with right name and right slug': function(err, docs) {
          var category;
          category = docs[0];
          assert.notEqual(category, void 0);
          assert.equal("Category 01", category.name);
          return assert.equal("category-01", category.slug);
        }
      }
    }
  }).addBatch({
    'A category provider': {
      topic: function() {
        return new CategoryProvider;
      },
      'gets all category': {
        topic: function(categoryProvider) {
          return categoryProvider.getAll(this.callback);
        },
        'and find one category': function(docs) {
          return assert.equal(1, docs.length);
        }
      }
    }
  }).addBatch({
    'An article provider': {
      topic: function() {
        return new ArticleProvider;
      },
      'deletes all articles': {
        topic: function(articleProvider) {
          return articleProvider.deleteAll(this.callback);
        },
        'without any error': function(err) {
          return assert.isUndefined(err.stack);
        }
      }
    }
  }).addBatch({
    'An article provider': {
      topic: function() {
        return new ArticleProvider;
      },
      'creates a new article for category 01': {
        topic: function(articleProvider) {
          var date;
          date = new time.Date();
          date.setTimezone("UTC");
          date.setMinutes(0);
          date.setHours(0);
          date.setSeconds(0);
          date.setMilliseconds(0);
          return articleProvider.newArticle(cat, "Article 01", date, this.callback);
        },
        'that has now an id': function(doc) {
          assert.notEqual(void 0, doc);
          return assert.isNotNull(doc._id);
        }
      }
    }
  }).addBatch({
    'An article provider': {
      topic: function() {
        return new ArticleProvider;
      },
      'gets all article for category 01': {
        topic: function(articleProvider) {
          return articleProvider.getAll(cat, this.callback);
        },
        'and find one article': function(docs) {
          return assert.equal(1, docs.length);
        }
      }
    }
  }).addBatch({
    'An article provider': {
      topic: function() {
        return new ArticleProvider;
      },
      'gets a given article for category 01': {
        topic: function(articleProvider) {
          var date;
          date = new time.Date();
          date.setTimezone("UTC");
          date.setMinutes(0);
          date.setHours(0);
          date.setSeconds(0);
          date.setMilliseconds(0);
          return articleProvider.getArticle(cat, date, "article-01", this.callback);
        },
        'and find corresponding article': function(docs) {
          return assert.equal(docs[0].slug, "article-01");
        }
      }
    }
  }).addBatch({
    'A category provider': {
      topic: function() {
        return new CategoryProvider;
      },
      'gets the new category': {
        topic: function(categoryProvider) {
          return categoryProvider.getCategory("category-01", this.callback);
        },
        'and deletes its articles': function(err, docs) {
          var articleProvider;
          assert.equal(1, docs.length);
          articleProvider = new ArticleProvider;
          articleProvider.deleteAllCategoryArticles(cat, this.callback);
          return {
            'without any error': function(err) {
              return assert.isUndefined(err.stack);
            }
          };
        }
      }
    }
  }).addBatch({
    'An article provider': {
      topic: function() {
        return new ArticleProvider;
      },
      'gets all articles linked to category-01': {
        topic: function(articleProvider) {
          return articleProvider.getAll(cat, this.callback);
        },
        'and find no article': function(docs) {
          return assert.equal(0, docs.length);
        }
      }
    }
  })["export"](module);

}).call(this);
