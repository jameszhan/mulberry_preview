$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mulberry_preview/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mulberry_preview"
  s.version     = MulberryPreview::VERSION
  s.authors     = ["James Zhan"]
  s.email       = ["zhiqiangzhan@gmail.com"]
  s.homepage    = "https://github.com/jameszhan/mulberry_preview"
  s.summary     = "Can preview files."
  s.description = "Can preview files."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.0"

  s.add_development_dependency "sqlite3"
end
