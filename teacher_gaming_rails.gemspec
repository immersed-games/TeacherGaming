$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "teacher_gaming/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "teacher_gaming_ruby"
  s.version     = TeacherGaming::VERSION
  s.authors     = ["Jeremy Baker"]
  s.email       = ["jeremy@immersedgames.com"]
  s.homepage    = "https://bitbucket.org/immersed_games/teacher-gaming-ruby"
  s.summary     = "A Ruby wrapper for TeacherGaming's HTTP API."
  s.description = "A Ruby wrapper for TeacherGaming's HTTP API."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.3"
  s.add_dependency "faraday"

  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rspec-rails', '~> 3.0'
end
