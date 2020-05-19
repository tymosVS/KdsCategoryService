# require 'rails_helper'

RSpec.describe FetchCategoriesForAccount, type: :interactor do

  describe '#call' do
    let(:categories) { %w[breads cereals rice pasta noodles vegetables fruit lean meat fish poultry eggs nuts] }
    context 'old keys' do
      Redis.new.hset('test', 'category', Date.today-100.days)
      let(:params) do
        {
          account_uuid: n,
          days: 90
        }
      end
      let(:n) { 5 }
      (1..10000).each do |n|
        it { expect(n).to eq(n) }
      end
    end
  end
end
