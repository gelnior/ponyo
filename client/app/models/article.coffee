class exports.Article extends Backbone.Model

  url: '/categories/'

  constructor: (article) ->
    super()
    
    @name = article.name
    @slug = article.slug
    @content = article.content
    @author = article.author
    @date = Date.parse(article.date)
    @id = article.id
    @categorySlug = article.categorySlug
    @categoryName = article.categoryName

    @dateToDisplay = moment(@date).format("YYYY/MM/DD")
    @dateSlug = moment(@date).format("YYYY-MM-DD-") + @slug
    @path = "/#{@dateToDisplay}/#{@slug}/"

    @url = "/categories/#{@categorySlug}/articles/#{@path}"

  isNew: () ->
    @id is undefined

