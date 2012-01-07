class exports.Article extends Backbone.Model

  url: '/categories/'

  constructor: (article) ->
    super()
    
    @name = article.name
    @slug = article.slug
    @content = article.content
    @author = author.content
    @date = date.content
    @id = article.id

    @url += @id + "/"

  isNew: () ->
    @id is undefined

