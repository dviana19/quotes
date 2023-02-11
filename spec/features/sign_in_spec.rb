# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'signing in', type: :feature do
  let!(:user) { create(:user, email: 'user@example.com') }
  let(:other_user) { User.new(email: 'other@example.com', password: 'rous') }

  it 'signing in with correct credentials' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: '123456'
    end
    click_button 'Log in'
    expect(page).to have_content user.company.name
    expect(page).to have_content 'A blazing fast quote editor built with Hotwire'
  end

  it 'signing in as another user' do
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user[email]', with: other_user.email
      fill_in 'user[password]', with: other_user.password
    end
    click_button 'Log in'
    expect(page).to have_current_path '/users/sign_in'
  end
end
