class exports.Article extends Backbone.Model

  url: '/categories/'

  constructor: (article) ->
    super()
    
    @name = article.name
    @slug = article.slug
    @content = article.content
    @author = article.content
    @date = article.date
    @id = article.id

    @url += @id + "/"

  isNew: () ->
    @id is undefined

