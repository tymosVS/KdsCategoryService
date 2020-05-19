# require 'rails_helper'

RSpec.describe SaveCategoriesForAccount, type: :interactor do
  describe '#call' do
    context '90 day period' do
      (30..90).each do |day|
        SaveCategoriesForAccount.call(account_uuid:'test3', category_names: ['one', 'none'])
        let(:params) do
          {
            account_uuid: 'test3',
            days: 0
          }
        end

        it { expect(FetchCategoriesForAccount.call(params).categories).to be_empty }
      end

      (1..30).each do |day|
        SaveCategoriesForAccount.call(account_uuid:'test4', category_names: ['one', 'none'])
        let(:params) do
          {
            account_uuid: 'test4',
            days: 0
          }
        end

        it { expect(FetchCategoriesForAccount.call(params).categories).to be_empty }
      end
    end
  end
end
