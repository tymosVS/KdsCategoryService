require 'redis'

REDIS_CONFIG = YAML.load( File.open( File.join(File.dirname(__FILE__), '../redis.yml'), 'r') ).symbolize_keys
dflt = REDIS_CONFIG[:default].symbolize_keys
cnfg = dflt.merge(REDIS_CONFIG[Rails.env.to_sym].symbolize_keys) if REDIS_CONFIG[Rails.env.to_sym]

$redis = Redis.new(cnfg)

$redis.flushdb if Rails.env = 'test'
