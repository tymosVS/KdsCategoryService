# frozen_string_literal: true

class SaveCategoriesForAccount
  include Interactor

  def call
    context.category_names.each do |category|
      redis_client.hset(context.account_uuid, category, Date.today)
    end
  end

  private

  def redis_client
    @redis ||= Redis.new
  end
end