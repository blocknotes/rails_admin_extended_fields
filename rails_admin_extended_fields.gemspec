$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_extended_fields/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_extended_fields"
  s.version     = RailsAdminExtendedFields::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "https://github.com/blocknotes/rails_admin_extended_fields"
  s.summary     = "RailsAdminExtendedFields plugin"
  s.description = "RailsAdminExtendedFields adds more options to rails_admin fields"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"
end
