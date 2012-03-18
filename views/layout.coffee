doctype 5
html ->
  head ->
    meta charset: 'utf-8'

    title "#{@title} | Ponyo CMS" if @title?
    meta(name: 'description', content: @description) if @description?

    link rel: 'icon', href: '/favicon.png'
    link rel: 'stylesheet', href: '/stylesheets/app.css'
  
    script src: '/javascripts/vendor.js'
    script src: '/javascripts/app.js'
    
    if @test
      link rel: 'stylesheet', href: '/tests/jasmine.css'
      script src: '/tests/jasmine.js'
      script src: '/client/public/tests/jasmine-html.js'


  body ->
    div id: 'content', ->
      @body
    
