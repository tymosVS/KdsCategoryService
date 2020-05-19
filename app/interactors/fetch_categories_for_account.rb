# frozen_string_literal: true

class FetchCategoriesForAccount
  include Interactor

  def call
    categories = []
    redis_client.hkeys(context.account_uuid).each do |category|
      if Date.today - Date.parse(redis_client.hmget(context.account_uuid, category)[0]) > 30.days
        redis_client.hdel(context.account_uuid, key)
      else
        if Date.today - Date.parse(redis_client.hmget(context.account_uuid, category)[0]) < context.days.days
          categories.push(category)
        end
      end
    end
    context.categories = categories
  end

  private

  def redis_client
    @redis ||= Redis.new
  end
end
