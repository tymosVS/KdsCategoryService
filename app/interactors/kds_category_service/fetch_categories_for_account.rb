# frozen_string_literal: true
module KdsCategoryService
  class FetchCategoriesForAccount
    include Interactor

    def call
      categories = []
      $redis.hkeys(context.account_uuid).each do |category|
        if Date.today - Date.parse($redis.hmget(context.account_uuid, category)[0]) > 30
          $redis.hdel(context.account_uuid, category)
        else
          if Date.today - Date.parse($redis.hmget(context.account_uuid, category)[0]) < context.days
            categories.push(category)
          end
        end
      end
      context.categories = categories
    end
  end
end
