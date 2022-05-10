# frozen_string_literal: true

REDIS_CLIENT = Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT'], db: 1)
RedisClassy.redis = REDIS_CLIENT
