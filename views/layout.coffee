doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title "#{@title} | Ponyo CMS" if @title?
    meta(name: 'description', content: @description) if @description?

    link rel: 'icon', href: '/favicon.png'
    link rel: 'stylesheet', href: '/stylesheets/style.css'

    script src: '/client/build/web/js/app.js'

  body ->
    div id: 'content', ->
      @body
     
