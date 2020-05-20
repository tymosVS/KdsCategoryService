# frozen_string_literal: true

RSpec.describe KdsCategoryService::SaveCategoriesForAccount do
  describe '#call' do
    context 'save uuid and category' do
      let(:params) { { account_uuid: 'test_2', category_names: %w[category category2] } }

      before do
        described_class.call(params)
      end
      subject do
        KdsCategoryService::FetchCategoriesForAccount.call(fetch_params).categories
      end
      let(:fetch_params) { { account_uuid: 'test_2', days: 30 } }
      it { expect(subject.count).to eq(2) }
    end

    context 'spead' do
      let(:categories) { %w[breads cereals rice pasta noodles vegetables fruit lean meat fish] }
      let(:params_categories) { categories.sample(rand(1..2)) }
      let(:params) do
        {
          account_uuid: 'test_speed',
          category_names: params_categories
        }
      end

      subject { described_class.call(params) }
      it { expect { subject }.to perform_under(10).ms }
    end
  end
end
