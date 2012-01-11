# Models
CategoryProvider = require("../models/models").CategoryProvider
ArticleProvider = require("../models/models").ArticleProvider


# Home page
exports.index = (req, res) ->
  res.render "index", title: "Ponyo", test: false

exports.indexTest = (req, res) ->
  res.render "index", title: "Ponyo", test: true


# Category list
exports.getCategories = (req, res)  ->
  categoryProvider = new CategoryProvider
  categoryProvider.getAll (err, docs) =>
    if err
       console.error(err.stack)
       docs = []
    res.json rows: docs

# Category creation
exports.newCategory = (req, res) ->
  name = req.body.name
  categoryProvider = new CategoryProvider

  if name
    categoryProvider.newCategory name, (err) ->
      if err
        console.error(err.stack)
        return res.json  success: false
      else
        return res.json  success: true
  else
    return res.json success: false

# Category deletion
exports.deleteCategory = (req, res) ->
  categoryProvider = new CategoryProvider

  categoryProvider.getCategory req.params.category, (err, docs) ->
    if err
      console.error(err.stack)
      res.json 'An error occured', 500
    else if docs.length > 0
      docs[0].remove (err) ->
        if err
          console.error(err.stack)
          res.json 'An error occured', 500
        else
          return res.json  success: true
    else
      res.json 'I dont have that', 404

# Category page
exports.category = (req, res) ->
  categoryProvider = new CategoryProvider
  categoryProvider.getCategory req.params.category, (err, docs) ->
    if err
      console.error(err.stack)
      res.json 'I dont have that', 404
    else if docs.length > 0
      res.json docs[0]
    else
      res.json 'I dont have that', 404



# Article list
exports.getArticles = (req, res)  ->
  categoryProvider = new CategoryProvider
  articleProvider = new ArticleProvider

  categoryProvider.getCategory req.params.category, (err, docs) ->
    if err
      console.error(err.stack)
      res.json 'An error occured', 500
    else if docs.length > 0
      category = docs[0]
        
      articleProvider.getAll category, (err, docs) ->
        if err
          console.error(err.stack)
          res.json 'An error occured', 500
        else
          res.json rows: docs

    else
      res.json 'Category not found', 404



