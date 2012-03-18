(function() {
  var ArticleProvider, Category, CategoryProvider, apiTest, assert, assertJSONHead, assertStatus, cookie, eyes, http, moment, request, rootUrl, time, vows;

  process.env.TZ = 'UTC';

  http = require('http');

  request = require('request');

  vows = require('vows');

  eyes = require('eyes');

  assert = require('assert');

  time = require('time')(Date);

  moment = require('moment');

  CategoryProvider = require("../models/models").CategoryProvider;

  ArticleProvider = require("../models/models").ArticleProvider;

  Category = require("../models/models").Category;

  rootUrl = "http://localhost:3000/";

  cookie = null;

  apiTest = {
    general: function(method, url, data, callback) {
      request({
        method: method,
        url: rootUrl + (url || ''),
        json: data || {},
        headers: {
          Cookie: cookie
        }
      }, callback);
    },
    get: function(url, callback) {
      return apiTest.general('GET', url, {}, callback);
    },
    post: function(url, data, callback) {
      return apiTest.general('POST', url, data, callback);
    },
    put: function(url, data, callback) {
      return apiTest.general('PUT', url, data, callback);
    },
    del: function(url, callback) {
      return apiTest.general('DELETE', url, {}, callback);
    }
  };

  assertStatus = function(code) {
    return function(error, response, body) {
      assert.notEqual(void 0, response);
      assert.equal(response.statusCode, code);
      return assert.ok(response.body);
    };
  };

  assertJSONHead = function() {
    return function(error, response, body) {
      return assert.equal(response.headers['content-type'], 'application/json; charset=utf-8');
    };
  };

  vows.describe('Resources').addBatch({
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
    'GET /': {
      topic: function() {
        return apiTest.get('', this.callback);
      },
      'response should be with a 200 OK': function(error, response, body) {
        assertStatus(200);
        return assert.ok(response.body);
      }
    }
  }).addBatch({
    'GET /categories/': {
      topic: function() {
        return apiTest.get('categories/', this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'response should contains one category': function(error, response, body) {
        var docs;
        docs = body.rows;
        assert.equal(1, docs.length);
        return assert.equal("Category 01", docs[0].name);
      }
    }
  }).addBatch({
    'GET /categories/category-01/': {
      topic: function() {
        return apiTest.get('categories/category-01/', this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'response should contains one category': function(error, response, body) {
        return assert.equal("Category 01", body.name);
      }
    }
  }).addBatch({
    'GET /categories/category-02/': {
      topic: function() {
        return apiTest.get('categories/category-02/', this.callback);
      },
      'response should be with a 404 not found': assertStatus(404)
    }
  }).addBatch({
    'POST /categories/': {
      topic: function() {
        return apiTest.post('categories/', {
          name: "Category 02"
        }, this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'respond body should tell that creation succeeds': function(error, response, body) {
        return assert.ok(body.success);
      }
    }
  }).addBatch({
    'GET /categories/category-02/': {
      topic: function() {
        return apiTest.get('categories/category-02/', this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'response should contains one category': function(error, response, body) {
        return assert.equal("Category 02", body.name);
      }
    }
  }).addBatch({
    'DELETE /categories/category-02/': {
      topic: function() {
        return apiTest.del('categories/category-02/', this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'GET /categories/category-02/': {
        topic: function() {
          return apiTest.get('categories/category-02/', this.callback);
        },
        'response should be with a 404 Not Found': assertStatus(404)
      },
      'DELETE /categories/category-02/': {
        topic: function() {
          return apiTest.del('categories/category-02/', this.callback);
        },
        'response should be with a 404 Not Found': assertStatus(404)
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
      'creates a new article': {
        topic: function(articleProvider) {
          var category, date;
          category = new Category({
            name: "Category 01",
            slug: "category-01"
          });
          date = new Date(2012, 0, 5, 0, 0, 0, 0);
          return articleProvider.newArticle(category, "Article 01", date, this.callback);
        },
        'that has now an id': function(doc) {
          assert.notEqual(void 0, doc);
          return assert.isNotNull(doc._id);
        }
      }
    }
  }).addBatch({
    'GET /categories/category-01/articles/': {
      topic: function() {
        return apiTest.get('categories/category-01/articles/', this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'response should contains one article': function(error, response, body) {
        var docs;
        assert.notEqual(void 0, body);
        docs = body.rows;
        assert.notEqual(void 0, docs);
        assert.equal(1, docs.length);
        return assert.equal("Article 01", docs[0].name);
      }
    }
  }).addBatch({
    'GET /categories/category-01/articles/2012/01/05/article-01/': {
      topic: function() {
        return apiTest.get('categories/category-01/articles/2012/01/05/article-01/', this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'response should contains one article': function(error, response, body) {
        return assert.equal(body.name, "Article 01");
      }
    }
  }).addBatch({
    'POST /categories/category-01/articles/': {
      topic: function() {
        return apiTest.post('categories/category-01/articles/', {
          name: "Article 02"
        }, this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'respond body should tell that creation succeeds': function(error, response, body) {
        return assert.ok(body.success);
      }
    }
  }).addBatch({
    'GET /categories/category-01/articles/yyyy/mm/dd/article-02/': {
      topic: function() {
        var date, url;
        date = new time.Date();
        date.setTimezone("UTC");
        date.setMinutes(0);
        date.setHours(0);
        date.setSeconds(0);
        date.setMilliseconds(0);
        url = 'categories/category-01/articles/';
        url += moment(date).format("YYYY/MM/DD/");
        url += 'article-02/';
        return apiTest.get(url, this.callback);
      },
      'response should be with a 200 OK': assertStatus(200),
      'response should contains one article': function(error, response, body) {
        return assert.equal(body.name, "Article 02");
      }
    }
  }).addBatch({
    'DELETE /categories/category-01/': {
      topic: function() {
        return apiTest.del('categories/category-01/', this.callback);
      },
      'response should be with a 200 OK': assertStatus(200)
    }
  }).addBatch({
    'An article provider': {
      topic: function() {
        return new ArticleProvider;
      },
      'gets all articles linked to category-01': {
        topic: function(articleProvider) {
          var category;
          category = new Category({
            name: "Category 01",
            slug: "category-01"
          });
          return articleProvider.getAll(category, this.callback);
        },
        'and find no article': function(docs) {
          return assert.equal(0, docs.length);
        }
      }
    }
  })["export"](module);

}).call(this);
