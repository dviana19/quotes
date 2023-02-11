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
    expect(page).to have_content 'Quote was successfully created.'
  end

  context 'when editing a quote' do
    let!(:quote) { create(:quote, company:) }

    it 'edits the quote' do
      visit quotes_path
      within("#quote_#{quote.id}") do
        click_on 'Edit'
        fill_in 'quote[name]', with: 'Replacing the original text'
        click_on 'Update quote'
      end
      expect(page).to have_content 'Replacing the original text'
      expect(page).to have_content 'Quote was successfully updated.'
    end
  end

  context 'when deleting a quote' do
    let!(:quote) { create(:quote, name: 'Should not be here', company:) }

    it 'deletes quote' do
      visit quotes_path
      within("#quote_#{quote.id}") do
        click_on 'Delete'
      end
      expect(page).not_to have_content 'Should not be here'
      expect(page).to have_content 'Quote was successfully destroyed.'
    end
  end
end
