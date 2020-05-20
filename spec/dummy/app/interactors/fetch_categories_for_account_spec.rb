# frozen_string_literal: true

RSpec.describe FetchCategoriesForAccount, type: :interactor do
  describe '#call' do
    10000.times do |n|
      context 'old keys' do
        $redis.hset('test', 'category', Date.today - 40.days)
        let(:params) do
          {
            account_uuid: 'test',
            days: 90
          }
        end

        it { expect(described_class.call(params).categories).to be_empty }
      end

      context 'search only for a certain number of days' do
        $redis.hset('test2', 'category1', Date.today - 25.days)
        $redis.hset('test2', 'category2', Date.today - 20.days)
        $redis.hset('test2', 'category3', Date.today - 15.days)
        let(:expected_response) { %w[category2 category3] }

        let(:params) do
          {
            account_uuid: 'test2',
            days: 25
          }
        end

        it { expect(described_class.call(params).categories).to eq(expected_response) }
      end

      context '90 days period' do
        context 'old values' do
          (31..90).each do |day|
            $redis.hset('test3', 'category' + day.to_s, Date.today - day)
            let(:params) do
              {
                account_uuid: 'test3',
                days: 90
              }
            end
          end
          it { expect(FetchCategoriesForAccount.call(params).categories).to be_empty }
        end

        context 'new values' do
          (1..31).each do |day|
            $redis.hset('test4', 'category' + day.to_s, Date.today - day)
            let(:params) do
              {
                account_uuid: 'test4',
                days: 90
              }
            end
          end
          it { expect(FetchCategoriesForAccount.call(params).categories.count).to eq(30) }
        end
      end

      context 'execution spead' do
        let(:categories) { %w[breads cereals rice pasta noodles vegetables fruit lean meat fish] }
        let(:params_categories) { categories.sample(rand(1..2)) }
        let(:account_uuid) { 'test_spead' }

        before do
          SaveCategoriesForAccount.call(account_uuid: account_uuid, category_names: params_categories)
        end

        subject { described_class.call(account_uuid: account_uuid, days: 30) }
        it { expect { subject }.to perform_under(10).ms }
      end
    end
  end
end
