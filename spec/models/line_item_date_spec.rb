# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItemDate, type: :model do
  subject { build(:line_item_date) }

  describe 'with factory' do
    it { is_expected.to be_valid }
  end

  describe 'with validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_uniqueness_of(:date).scoped_to(:quote_id) }
  end

  describe 'with assocations' do
    it { is_expected.to belong_to(:quote) }
  end

  describe 'with public object methods' do
    context 'when executes methods correctly' do
      context 'with previous date' do
        let(:quote) { create(:quote) }
        let(:line_item_date) { create(:line_item_date, quote:) }

        before do
          @line1 = create(:line_item_date, date: Time.zone.today - 10.days, quote:)
          @line2 = create(:line_item_date, date: Time.zone.today - 2.days, quote:)
          @line3 = create(:line_item_date, date: Time.zone.today - 5.days, quote:)
        end

        it { expect(@line2).to eq line_item_date.previous_date }
      end
    end
  end
end
