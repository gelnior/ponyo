time = require('time')

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
  articleProvider = new ArticleProvider

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
          articleProvider.deleteAllCategoryArticles docs[0], (err) ->
          if err
            console.error(err.stack)
            return res.json 'An error occured while deleting linked articles', \
                            500
          else
            return res.json  success: true
    else
      return res.json 'I dont have that', 404

# Category object
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


getArticleFromRequestDate = (date, req, res, callback) ->
  categoryProvider = new CategoryProvider
  articleProvider = new ArticleProvider

  catSlug = req.params.category
  articleSlug = req.params.article

  categoryProvider.getCategory catSlug, (err, docs) ->

    if err
      console.error(err.stack)
      res.json 'An error occured', 500

    else if docs.length > 0
      category = docs[0]
      articleProvider.getArticle category, date, articleSlug, (err, docs) ->
        if err
          console.error(err.stack)
          res.json 'An error occured', 500
        else
          callback(category, docs)
    else
      res.json 'Category not found', 404



# Article object
exports.getArticle = (req, res) ->
  year = parseInt(req.params.year)
  month = parseInt(req.params.month)
  day = parseInt(req.params.day)
  mydate = new time.Date(year, month - 1, day, 0, 0, 0, 0)

  getArticleFromRequestDate mydate, req, res, (category, docs) ->
    console.log docs
    if docs.length > 0
      res.json docs[0]
    else
      res.json 'I dont have that', 404


# Article creation
exports.newArticle = (req, res) ->

  date = new time.Date()
  date.setTimezone("UTC")
  date.setMinutes(0)
  date.setHours(0)
  date.setSeconds(0)
  date.setMilliseconds(0)

  getArticleFromRequestDate date, req, res, (category, docs) ->
    articleProvider = new ArticleProvider

    if docs.length > 0
      res.json 'Article already exists', 400
    else
        name = req.body.name

       if name
         articleProvider.newArticle category, name, date, (err) ->
           if err
             console.error(err.stack)
             return res.json  success: false
           else
             return res.json  success: true
    else
      return res.json success: false


