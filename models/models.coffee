mongoose = require('mongoose')

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

class CategoryProvider
  getAll: (callback) ->
    query = Category.find {}
    query.exec callback

  newCategory: (name, callback) ->
    category = new Category name: name
    category.save callback

exports.CategoryProvider = CategoryProvider

