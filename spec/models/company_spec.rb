# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  subject { build(:company) }

  describe 'factory' do
    it { is_expected.to be_valid }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'assocations' do
    it { is_expected.to have_many(:quotes) }
    it { is_expected.to have_many(:users) }
  end
end
