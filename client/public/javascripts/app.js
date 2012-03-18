(function(/*! Brunch !*/) {
  if (!this.require) {
    var modules = {}, cache = {}, require = function(name, root) {
      var module = cache[name], path = expand(root, name), fn;
      if (module) {
        return module;
      } else if (fn = modules[path] || modules[path = expand(path, './index')]) {
        module = {id: name, exports: {}};
        try {
          cache[name] = module.exports;
          fn(module.exports, function(name) {
            return require(name, dirname(path));
          }, module);
          return cache[name] = module.exports;
        } catch (err) {
          delete cache[name];
          throw err;
        }
      } else {
        throw 'module \'' + name + '\' not found';
      }
    }, expand = function(root, name) {
      var results = [], parts, part;
      if (/^\.\.?(\/|$)/.test(name)) {
        parts = [root, name].join('/').split('/');
      } else {
        parts = name.split('/');
      }
      for (var i = 0, length = parts.length; i < length; i++) {
        part = parts[i];
        if (part == '..') {
          results.pop();
        } else if (part != '.' && part != '') {
          results.push(part);
        }
      }
      return results.join('/');
    }, dirname = function(path) {
      return path.split('/').slice(0, -1).join('/');
    };
    this.require = function(name) {
      return require(name, '');
    };
    this.require.brunch = true;
    this.require.define = function(bundle) {
      for (var key in bundle)
        modules[key] = bundle[key];
    };
  }
}).call(this);(this.require.define({
  "templates/categories": function(exports, require, module) {
    module.exports = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push('<div id="home-view">\n  <p>Add a category</p>\n  <p>\n    <input id="category-field" type="text">\n    <input id="category-add-submit" type="submit" value="Add category">\n\n    <ul id="category-list">\n    </ul>\n  </p>\n</div>\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
}
  }
}));
(this.require.define({
  "main": function(exports, require, module) {
    
/* Application entry point
*/

(function() {
  var ArticleView, CategoryView, HomeView, MainRouter;

  window.app = {};

  app.routers = {};

  app.models = {};

  app.collections = {};

  app.views = {};

  MainRouter = require('routers/main_router').MainRouter;

  HomeView = require('views/home_view').HomeView;

  CategoryView = require('views/category_view').CategoryView;

  ArticleView = require('views/article_view').ArticleView;

  $(document).ready(function() {
    app.initialize = function() {
      app.routers.main = new MainRouter();
      app.views.home = new HomeView();
      app.views.category = new CategoryView();
      return app.views.article = new ArticleView();
    };
    app.start = function() {
      if (Backbone.history.getFragment() === '') {
        return app.routers.main.navigate('home', true);
      }
    };
    app.initialize();
    Backbone.history.start({
      root: "/"
    });
    return app.start();
  });

}).call(this);

  }
}));
(this.require.define({
  "views/category": function(exports, require, module) {
    (function() {
  var categoryTemplate,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  categoryTemplate = require('templates/category');

  exports.CategoryRow = (function(_super) {

    __extends(CategoryRow, _super);

    CategoryRow.prototype.tagName = "li";

    CategoryRow.prototype.className = "category-row";

    function CategoryRow(model) {
      this.model = model;
      CategoryRow.__super__.constructor.call(this);
      this.id = this.model.slug;
      this.model.view = this;
    }

    CategoryRow.prototype.events = {
      "click": "onClicked"
    };

    CategoryRow.prototype.onClicked = function(event) {
      return app.routers.main.navigate("categories/" + this.model.slug, true);
    };

    CategoryRow.prototype.remove = function() {
      return $(this.el).remove();
    };

    CategoryRow.prototype.render = function() {
      $(this.el).html(categoryTemplate({
        category: this.model
      }));
      return this.el;
    };

    return CategoryRow;

  })(Backbone.View);

}).call(this);

  }
}));
(this.require.define({
  "views/article_view": function(exports, require, module) {
    (function() {
  var Article, articleViewTemplate,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  articleViewTemplate = require('../templates/article_view');

  Article = require('../models/article').Article;

  exports.ArticleView = (function(_super) {

    __extends(ArticleView, _super);

    ArticleView.prototype.id = 'article-view';

    ArticleView.prototype.events = {
      "click #delete-article-button": "onDeleteButtonClicked"
    };

    /* Events
    */

    /* Constructor
    */

    function ArticleView() {
      this.onDeleteButtonClicked = __bind(this.onDeleteButtonClicked, this);
      this.setListeners = __bind(this.setListeners, this);      ArticleView.__super__.constructor.call(this);
    }

    /* Listeners
    */

    ArticleView.prototype.setListeners = function() {
      return this.deleteButton.click(this.onDeleteButtonClicked);
    };

    ArticleView.prototype.onDeleteButtonClicked = function(event) {
      event.preventDefault();
      return this.model.destroy({
        success: function() {
          return app.routers.main.navigate("categories/" + this.model.categorySlug, true);
        },
        error: function() {
          return alert("An error occured, category was probably not deleted.");
        }
      });
    };

    /* Functions
    */

    ArticleView.prototype.render = function(category, year, month, day, article) {
      var _this = this;
      $("#nav-content").html(null);
      return $.get(("/categories/" + category + "/articles/") + ("" + year + "/" + month + "/" + day + "/" + article), function(data) {
        _this.model = new Article(data);
        $("#nav-content").html(articleViewTemplate({
          article: _this.model
        }));
        _this.deleteButton = $("#delete-category-button");
        return _this.setListeners();
      });
    };

    return ArticleView;

  })(Backbone.View);

}).call(this);

  }
}));
(this.require.define({
  "views/article": function(exports, require, module) {
    (function() {
  var articleTemplate,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  articleTemplate = require('templates/article');

  exports.ArticleRow = (function(_super) {

    __extends(ArticleRow, _super);

    ArticleRow.prototype.tagName = "li";

    ArticleRow.prototype.className = "article-row";

    function ArticleRow(model) {
      this.model = model;
      ArticleRow.__super__.constructor.call(this);
      this.id = this.model.slug;
      this.model.view = this;
    }

    ArticleRow.prototype.events = {
      "click": "onClicked"
    };

    ArticleRow.prototype.onClicked = function(event) {
      return app.routers.main.navigate("categories/" + this.model.categorySlug + "/articles" + this.model.path, true);
    };

    ArticleRow.prototype.remove = function() {
      return $(this.el).remove();
    };

    ArticleRow.prototype.render = function() {
      $(this.el).html(articleTemplate({
        article: this.model
      }));
      return this.el;
    };

    return ArticleRow;

  })(Backbone.View);

}).call(this);

  }
}));
(this.require.define({
  "views/home_view": function(exports, require, module) {
    (function() {
  var Category, CategoryCollection, CategoryRow, categoryTemplate,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  require("utils/string");

  categoryTemplate = require('templates/categories');

  Category = require('models/category').Category;

  CategoryCollection = require('collections/category').CategoryCollection;

  CategoryRow = require('views/category').CategoryRow;

  exports.HomeView = (function(_super) {

    __extends(HomeView, _super);

    HomeView.prototype.id = 'home-view';

    /* Events
    */

    HomeView.prototype.events = {
      "click #category-add-submit": "onAddCategoryClicked"
    };

    /* Constructor
    */

    function HomeView() {
      this.addCategoryToCategoryList = __bind(this.addCategoryToCategoryList, this);
      this.fillCategories = __bind(this.fillCategories, this);
      this.onAddCategoryClicked = __bind(this.onAddCategoryClicked, this);
      this.setListeners = __bind(this.setListeners, this);      HomeView.__super__.constructor.call(this);
      this.categories = new CategoryCollection();
    }

    /* Listeners
    */

    HomeView.prototype.setListeners = function() {
      this.categories.bind('reset', this.fillCategories);
      return this.addButton.click(this.onAddCategoryClicked);
    };

    HomeView.prototype.onAddCategoryClicked = function(event) {
      var categoryName,
        _this = this;
      categoryName = this.categoryField.val();
      return $.ajax({
        type: 'POST',
        url: "/categories/",
        data: {
          name: categoryName
        },
        success: function() {
          var category;
          category = new Category({
            "name": categoryName,
            "slug": categoryName.slugify()
          });
          return _this.addCategoryToCategoryList(category);
        },
        dataType: "json"
      });
    };

    /* Functions
    */

    HomeView.prototype.fillCategories = function() {
      this.categoryList.html(null);
      return this.categories.forEach(this.addCategoryToCategoryList);
    };

    HomeView.prototype.addCategoryToCategoryList = function(category) {
      var categoryRow, el;
      categoryRow = new CategoryRow(category);
      el = categoryRow.render();
      this.categoryList.append(el);
      return el.id = category.slug;
    };

    /* Render
    */

    HomeView.prototype.render = function() {
      this.content = $("#nav-content");
      this.content.html(categoryTemplate());
      this.categoryList = $("#category-list");
      this.categoryField = $("#category-field");
      this.addButton = $("#category-add-submit");
      this.setListeners();
      this.categoryList.html(null);
      return this.categories.fetch();
    };

    return HomeView;

  })(Backbone.View);

}).call(this);

  }
}));
(this.require.define({
  "routers/main_router": function(exports, require, module) {
    (function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  exports.MainRouter = (function(_super) {

    __extends(MainRouter, _super);

    function MainRouter() {
      MainRouter.__super__.constructor.apply(this, arguments);
    }

    MainRouter.prototype.routes = {
      "home": "home",
      "categories/:category": "category",
      "categories/:category/articles/:year/:month/:day/:article/": "article"
    };

    MainRouter.prototype.home = function() {
      return app.views.home.render();
    };

    MainRouter.prototype.category = function(category) {
      return app.views.category.render(category);
    };

    MainRouter.prototype.article = function(category, year, month, day, article) {
      return app.views.article.render(category, year, month, day, article);
    };

    return MainRouter;

  })(Backbone.Router);

}).call(this);

  }
}));
(this.require.define({
  "views/category_view": function(exports, require, module) {
    (function() {
  var Article, ArticleCollection, ArticleRow, Category, articleTemplate, categoryViewTemplate,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  categoryViewTemplate = require('../templates/category_view');

  Category = require('../models/category').Category;

  articleTemplate = require('templates/article');

  Article = require('models/article').Article;

  ArticleRow = require('views/article').ArticleRow;

  ArticleCollection = require('collections/article').ArticleCollection;

  exports.CategoryView = (function(_super) {

    __extends(CategoryView, _super);

    CategoryView.prototype.id = 'category-view';

    CategoryView.prototype.events = {
      "click #delete-category-button": "onDeleteButtonClicked",
      "click #article-add-submti": "onAddArticleClicked"
    };

    /* Events
    */

    /* Constructor
    */

    function CategoryView() {
      this.addArticleToArticleList = __bind(this.addArticleToArticleList, this);
      this.fillArticles = __bind(this.fillArticles, this);
      this.onDeleteButtonClicked = __bind(this.onDeleteButtonClicked, this);
      this.onAddArticleClicked = __bind(this.onAddArticleClicked, this);
      this.setListeners = __bind(this.setListeners, this);      CategoryView.__super__.constructor.call(this);
    }

    /* Listeners
    */

    CategoryView.prototype.setListeners = function() {
      this.deleteButton.click(this.onDeleteButtonClicked);
      return $("#article-add-submit").click(this.onAddArticleClicked);
    };

    CategoryView.prototype.onAddArticleClicked = function(event) {
      var articleName,
        _this = this;
      articleName = this.articleField.val();
      return $.ajax({
        type: 'POST',
        url: this.articles.url,
        data: {
          name: articleName
        },
        success: function() {
          var article, date;
          date = new Date();
          date.setHours(0);
          date.setMinutes(0);
          date.setSeconds(0);
          article = new Article({
            "name": articleName,
            "slug": articleName.slugify(),
            "date": date
          });
          return _this.addArticleToArticleList(article);
        },
        dataType: "json"
      });
    };

    CategoryView.prototype.onDeleteButtonClicked = function(event) {
      event.preventDefault();
      return this.model.destroy({
        success: function() {
          return app.routers.main.navigate("home", true);
        },
        error: function() {
          return alert("An error occured, category was probably not deleted.");
        }
      });
    };

    CategoryView.prototype.fillArticles = function() {
      this.articleList.html(null);
      return this.articles.forEach(this.addArticleToArticleList);
    };

    CategoryView.prototype.addArticleToArticleList = function(article) {
      var articleRow, el;
      articleRow = new ArticleRow(article);
      el = articleRow.render();
      this.articleList.append(el);
      return el.id = article.dateSlug;
    };

    /* Functions
    */

    CategoryView.prototype.render = function(category) {
      var _this = this;
      $("#nav-content").html(null);
      return $.get("/categories/" + category + "/", function(data) {
        $("#nav-content").html(categoryViewTemplate({
          category: data
        }));
        _this.model = new Category(data);
        _this.deleteButton = $("#delete-category-button");
        _this.addButton = $("#article-add-submit");
        _this.articleField = $("#article-field");
        _this.articleList = $("#article-list");
        _this.setListeners();
        _this.articles = new ArticleCollection(data);
        _this.articles.bind('reset', _this.fillArticles);
        return _this.articles.fetch();
      });
    };

    return CategoryView;

  })(Backbone.View);

}).call(this);

  }
}));
(this.require.define({
  "templates/article_view": function(exports, require, module) {
    module.exports = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push('<p>\n  <a id="back-category" href="#categories/');
    
      __out.push(__sanitize(this.article.categorySlug));
    
      __out.push('">\n    Back to category\n  </a>\n</p>\n<h4>\n  ');
    
      __out.push(__sanitize(this.article.categoryName));
    
      __out.push(' >>\n</h4>\n<h1 class="article-title">\n  ');
    
      __out.push(__sanitize(this.article.name));
    
      __out.push('\n</h1>\n<p>');
    
      __out.push(__sanitize(this.article.dateToDisplay));
    
      __out.push('</p>\n<p>');
    
      __out.push(__sanitize(this.article.author));
    
      __out.push('</p>\n<h2>Content</h2>\n<div id="article-content">\n  ');
    
      __out.push(__sanitize(this.article.content));
    
      __out.push('\n</div>\n\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
}
  }
}));
(this.require.define({
  "utils/string": function(exports, require, module) {
    (function() {

  String.prototype.slugify = function() {
    var s, _slugify_hyphenate_re, _slugify_strip_re;
    _slugify_strip_re = /[^\w\s-]/g;
    _slugify_hyphenate_re = /[-\s]+/g;
    s = this.replace(_slugify_strip_re, '').trim().toLowerCase();
    s = s.replace(_slugify_hyphenate_re, '-');
    return s;
  };

}).call(this);

  }
}));
(this.require.define({
  "templates/category_view": function(exports, require, module) {
    module.exports = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push('<p>\n  <a id="back-categories" href="#home">Back to categories</a>\n</p>\n<h1>\n  ');
    
      __out.push(__sanitize(this.category.name));
    
      __out.push('\n</h1>\n<p>Add an article</p>\n<input id="article-field" type="text">\n<input id="article-add-submit" type="submit" value="Add article">\n<h2>Articles</h2>\n<ul id="article-list">\n</ul>\n<p>\n  <a id="delete-category-button" href="#home">\n    Delete category\n  </a>\n</p>\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
}
  }
}));
(this.require.define({
  "templates/article": function(exports, require, module) {
    module.exports = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push(__sanitize(this.article.dateToDisplay));
    
      __out.push(' - ');
    
      __out.push(__sanitize(this.article.name));
    
      __out.push('\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
}
  }
}));
(this.require.define({
  "templates/category": function(exports, require, module) {
    module.exports = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push(__sanitize(this.category.name));
    
      __out.push('\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
}
  }
}));
(this.require.define({
  "templates/home": function(exports, require, module) {
    module.exports = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push('<!-- START you can remove this -->\n<div id="content">\n  <span id="props">with coffee</span>\n  <h1>brunch</h1>\n  <h2>Welcome!</h2>\n  <ul>\n    <li><a href="http://brunchwithcoffee.com/#documentation">Documentation</a></li>\n    <li><a href="https://github.com/brunch/brunch/issues">Github Issues</a></li>\n    <li><a href="https://github.com/brunch/example-todos">Todos Example App</a></li>\n  </ul>\n</div>\n<!-- END you can remove this -->\n\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
}
  }
}));
(this.require.define({
  "models/article": function(exports, require, module) {
    (function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  exports.Article = (function(_super) {

    __extends(Article, _super);

    Article.prototype.url = '/categories/';

    function Article(article) {
      Article.__super__.constructor.call(this);
      this.name = article.name;
      this.slug = article.slug;
      this.content = article.content;
      this.author = article.author;
      this.date = Date.parse(article.date);
      this.id = article.id;
      this.categorySlug = article.categorySlug;
      this.categoryName = article.categoryName;
      this.dateToDisplay = moment(this.date).format("YYYY/MM/DD");
      this.dateSlug = moment(this.date).format("YYYY-MM-DD-") + this.slug;
      this.path = "/" + this.dateToDisplay + "/" + this.slug + "/";
      this.url = "/categories/" + this.categorySlug + "/articles/" + this.path;
    }

    Article.prototype.isNew = function() {
      return this.id === void 0;
    };

    return Article;

  })(Backbone.Model);

}).call(this);

  }
}));
(this.require.define({
  "collections/category": function(exports, require, module) {
    (function() {
  var Category,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Category = require("models/category").Category;

  exports.CategoryCollection = (function(_super) {

    __extends(CategoryCollection, _super);

    CategoryCollection.prototype.model = Category;

    CategoryCollection.prototype.url = '/categories/';

    function CategoryCollection() {
      CategoryCollection.__super__.constructor.call(this);
    }

    CategoryCollection.prototype.parse = function(response) {
      return response.rows;
    };

    return CategoryCollection;

  })(Backbone.Collection);

}).call(this);

  }
}));
(this.require.define({
  "models/category": function(exports, require, module) {
    (function() {
  var __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  exports.Category = (function(_super) {

    __extends(Category, _super);

    Category.prototype.url = '/categories/';

    function Category(category) {
      Category.__super__.constructor.call(this);
      this.name = category.name;
      this.slug = category.slug;
      this.id = category.slug;
      this.url += this.id + "/";
    }

    Category.prototype.isNew = function() {
      return this.id === void 0;
    };

    return Category;

  })(Backbone.Model);

}).call(this);

  }
}));
(this.require.define({
  "collections/article": function(exports, require, module) {
    (function() {
  var Article,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  Article = require("models/article").Article;

  exports.ArticleCollection = (function(_super) {

    __extends(ArticleCollection, _super);

    ArticleCollection.prototype.model = Article;

    ArticleCollection.prototype.url = '/categories/articles/';

    function ArticleCollection(category) {
      ArticleCollection.__super__.constructor.call(this);
      this.url = "/categories/" + category.slug + "/articles/";
    }

    ArticleCollection.prototype.parse = function(response) {
      return response.rows;
    };

    return ArticleCollection;

  })(Backbone.Collection);

}).call(this);

  }
}));
