# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with factories' do
    subject { build(:user) }

    it { is_expected.to be_valid }
  end

  describe 'with validations' do
    it { is_expected.to validate_presence_of(:email) }

    context 'with no email' do
      subject { build(:user, email: nil) }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'with assocations' do
    it { is_expected.to belong_to(:company) }
  end

  describe 'with public object methods' do
    context 'when executes methods correctly' do
      context 'with type' do
        it { expect(build(:user, email: 'diogo@gmail.com').name).to eq 'Diogo' }
      end
    end
  end
end
