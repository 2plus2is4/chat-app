module Countable
  extend ActiveSupport::Concern

  private

  def increment_count(set, key)
    RedisMutex.with_lock(:counts_lock) do
      REDIS_CLIENT.sadd(set, key)
      REDIS_CLIENT.incr(key)
    end
  end

  def decrement_count(set, key)
    RedisMutex.with_lock(:counts_lock) do
      REDIS_CLIENT.srem(set, key) if REDIS_CLIENT.decr(key) < 1
    end
  end
end
