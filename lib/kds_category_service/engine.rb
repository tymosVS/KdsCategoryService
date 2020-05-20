module KdsCategoryService
  class Engine < ::Rails::Engine
    isolate_namespace KdsCategoryService

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end

    require_relative '../../config/initializers/redis'
  end
end
