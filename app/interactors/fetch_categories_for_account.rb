# frozen_string_literal: true

class FetchCategoriesForAccount
  include Interactor

  def call
    categories = []
    redis_client.hkeys(context.account_uuid).each do |category|
      if Date.today - Date.parse(redis_client.hmget(context.account_uuid, category)[0]) > 30
        redis_client.hdel(context.account_uuid, category)
      else
        if Date.today - Date.parse(redis_client.hmget(context.account_uuid, category)[0]) < context.days
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
