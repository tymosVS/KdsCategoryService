# frozen_string_literal: true

module KdsCategoryService
  class SaveCategoriesForAccount
    include Interactor

    def call
      context.category_names.each do |category|
        $redis.hset(context.account_uuid, category, Date.today)
      end
    end
  end
end
