mongoose = require('mongoose')

# Utils
require("../public/client/src/app/utils/string")

# DB
mongoose.connect('mongodb://127.0.0.1/ponyo')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

# Models
extraField = new Schema name : String, type : String

categorySchema = new Schema
  name : String
  slug : type : String, lowercase : true
  extraFields : [extraField]

Category = mongoose.model('Category', categorySchema)
exports.Category = Category

articleSchema = new Schema
  name: String
  slug: type : String, lowercase : true
  content: String
  date : Date
  author : String
  published : Boolean
  categoryName: String
  categorySlug: String

Article = mongoose.model('Article', articleSchema)


# Providers

class CategoryProvider
  
  # Get all categories.
  getAll: (callback) ->
    query = Category.find {}
    query.exec callback
    return

  # Delete all categories
  deleteAll: (callback) ->
    query = Category.remove {}, callback
    return

  # Get a category from its slug.
  getCategory: (slug, callback) ->
    query = Category.find { "slug": slug }
    query.limit 1
    query.exec callback
    return

  # Create a new category if it does not exist.
  newCategory: (name, callback) ->
    slug = name.slugify()
    @getCategory slug, (err, docs) ->
      if docs.length > 0
        callback(new Error("Category already exists"), [])
      else
        category = new Category name: name, slug: name.slugify()
        category.save callback
    return
 
exports.CategoryProvider = CategoryProvider


# Articles

class ArticleProvider
  
  # Get all article for given category.
  getAll: (category, callback) ->
    query = Article.find { categorySlug: category.slug }
    query.exec callback
    return

  # Delete all articles
  deleteAll: (callback) ->
    query = Article.remove {}, callback
    return

  # Get an article from its slug, date and category.
  getArticle: (category, date, slug, callback) ->
    query = Article.find
        "date": date,
        "slug": slug,
        "categorySlug": category.slug
    query.limit 1
    query.exec callback
    return

  # Create a new article for given category. 
  newArticle: (category, name, date, callback) ->
   
    article = new Article
      name: name,
      slug: name.slugify(),
      date: date,
      categoryName: category.name,
      categorySlug: category.slug,
    
    article.save callback
    return
 
exports.ArticleProvider = ArticleProvider


