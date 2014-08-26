module MulberryPreview
end

if defined? Rails
  require 'mulberry_preview/engine'
  require 'mulberry_preview/markdown/render'
#  require 'mulberry_preview/railtie'
end
