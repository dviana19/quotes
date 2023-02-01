# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Quote, type: :model do
  subject { build(:quote) }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'assocations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:line_item_dates) }
  end

  describe 'with public object methods' do
    context 'when executes methods correctly' do
      context 'with total price' do
        let(:quote) { create(:quote) }
        let(:line_item_date) { create(:line_item_date, quote:) }

        before { create_list(:line_item, 2, unit_price: 20, quantity: 5, line_item_date:) }

        it { expect(quote.total_price).to eq 200 }
      end
    end
  end
end
