String.prototype.slugify = () ->
  _slugify_strip_re = /[^\w\s-]/g
  _slugify_hyphenate_re = /[-\s]+/g
  s = @.replace(_slugify_strip_re, '').trim().toLowerCase()
  s = s.replace(_slugify_hyphenate_re, '-')
  s

