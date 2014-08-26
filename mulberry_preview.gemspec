$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'mulberry_preview/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'mulberry_preview'
  s.version     = MulberryPreview::VERSION
  s.authors     = ['James Zhan']
  s.email       = ['zhiqiangzhan@gmail.com']
  s.homepage    = 'https://github.com/jameszhan/mulberry_preview'
  s.summary     = 'Can preview files.'
  s.description = 'Can preview files and format the view.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.licenses = %w[MIT, GPL-2]

  s.add_runtime_dependency 'rails', '~> 4.1', '>= 4.1.0'
  s.add_runtime_dependency 'bootstrap-sass-rails', '~> 3'

  s.add_runtime_dependency 'coderay', '~> 1'
  s.add_runtime_dependency 'redcarpet', '~> 3', '>= 3'

  s.add_development_dependency 'sqlite3', '~> 1'
end
