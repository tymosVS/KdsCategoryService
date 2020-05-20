module KdsCategoryService
  class Engine < ::Rails::Engine
    isolate_namespace KdsCategoryService

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
