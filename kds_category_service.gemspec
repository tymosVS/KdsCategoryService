$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "kds_category_service/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "kds_category_service"
  spec.version     = KdsCategoryService::VERSION
  spec.authors     = ["Vladymyr Tymoshenko"]
  spec.email       = ["timos9vs@gmail.com"]
  spec.homepage    = "http://homepage.com"
  spec.summary     = "Summary of KdsCategoryService."
  spec.description = "Description of KdsCategoryService."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.test_files = Dir["spec/**/*"]
  spec.add_dependency "rails", "~> 6.0.3"
  spec.add_development_dependency 'interactor'
  spec.add_development_dependency 'redis'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rspec-rails'

end
