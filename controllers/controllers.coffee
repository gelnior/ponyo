# Models
CategoryProvider = require("../models/models").CategoryProvider

# Home page
exports.index = (req, res) ->
  categoryProvider = new CategoryProvider
  categoryProvider.getAll (err, docs) ->
    if err
       console.error(err.stack)
       docs = []
    res.render "index", title: "Ponyo", categories: docs


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

# Category page
exports.category = (req, res) ->
  res.render "category", nbArticles: 0, category: req.params.category, articles: []

