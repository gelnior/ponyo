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


