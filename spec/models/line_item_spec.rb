# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItem, type: :model do
  subject { build(:line_item) }

  describe 'with factory' do
    it { is_expected.to be_valid }
  end

  describe 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer }
    it { is_expected.to validate_presence_of(:unit_price) }
    it { is_expected.to validate_numericality_of(:unit_price).is_greater_than(0) }
  end

  describe 'with assocations' do
    it { is_expected.to belong_to(:line_item_date) }
  end

  describe 'with public object methods' do
    context 'when executes methods correctly' do
      context 'with total price' do
        let(:line_item) { create(:line_item, unit_price: 25, quantity: 3) }

        it { expect(line_item.total_price).to eq 75 }
      end
    end
  end
end
