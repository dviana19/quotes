# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'quotes management', type: :feature do
  let(:user) { create(:user, email: 'user@example.com', company:) }
  let(:company) { create(:company) }

  before do
    sign_in(user)
    create(:quote, name: 'A quote example', company:)
    create(:quote, name: 'Another company quote')
  end

  it 'lists quotes' do
    visit quotes_path
    expect(page).to have_content 'A quote example'
    expect(page).not_to have_content 'Another company quote'
  end

  it 'creates quote' do
    visit quotes_path
    click_on 'New quote'
    within('form#new_quote') do
      fill_in 'quote[name]', with: 'This is awesome'
    end
    click_on 'Create quote'
    expect(page).to have_selector('#quotes turbo-frame', count: 2)
  end

  it 'edits quote' do
    visit quotes_path
    click_on 'Edit'
    within('form.quote') do
      fill_in 'quote[name]', with: 'Replacing the original text'
    end
    click_on 'Update quote'
    expect(page).not_to have_content 'A quote example'
    expect(page).to have_content 'Replacing the original text'
  end

  it 'deletes quote' do
    visit quotes_path
    click_on 'Delete'
    expect(page).to have_selector('#quotes turbo-frame', count: 0)
  end
end
