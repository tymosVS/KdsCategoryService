# require 'rails_helper'

RSpec.describe FetchCategoriesForAccount, type: :interactor do

  describe '#call' do
    let(:categories) { %w[breads cereals rice pasta noodles vegetables fruit lean meat fish poultry eggs nuts] }
    context 'old keys' do
      Redis.new.hset('test', 'category', Date.today-100.days)
      let(:params) do
        {
          account_uuid: 'test',
          days: 200
        }
      end

      it { expect(described_class.call(params).categories).to be_empty }
      Redis.new.del('test')
    end

    context 'search only for a certain number of days' do
      Redis.new.hset('test2', 'category1', Date.today-25.days)
      Redis.new.hset('test2', 'category2', Date.today-20.days)
      Redis.new.hset('test2', 'category3', Date.today-15.days)
      let(:expected_response){ ['category2', 'category3'] }

      let(:params) do
        {
          account_uuid: 'test2',
          days: 25
        }
      end

      it { expect(described_class.call(params).categories).to eq(expected_response) }
    end
  end
end
