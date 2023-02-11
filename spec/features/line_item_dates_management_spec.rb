# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'dates management', type: :feature do
  let(:company) { create(:company) }
  let(:user) { create(:user, email: 'user@example.com', company:) }
  let!(:quote) { create(:quote, name: 'A quote example', company:) }

  before { sign_in(user) }

  it 'lists dates' do
    visit quote_path(quote)
    expect(page).to have_content 'A quote example'
    expect(page).to have_content '$0.00'
  end

  it 'creates dates' do
    visit quote_path(quote)
    click_on 'New date'
    within('form#new_line_item_date') do
      fill_in 'line_item_date[date]', with: '19/03/1984'
    end
    click_on 'Create date'
    expect(page).to have_content('March 19, 1984')
    expect(page).to have_content('Date was successfully created.')
  end

  context 'when editing a date' do
    let!(:date) { create(:line_item_date, date: Date.parse('2023-01-01'), quote:) }

    it 'edits date' do
      visit quote_path(quote)
      click_on 'Edit'
      within("form#edit_line_item_date_#{date.id}") do
        fill_in 'line_item_date[date]', with: '02.01.2023'
      end
      click_on 'Update date'
      expect(page).to have_content('January 02, 2023')
      expect(page).to have_content('Date was successfully updated.')
    end
  end

  context 'when deleting a date' do
    let!(:date) { create(:line_item_date, date: Date.parse('2023-01-01'), quote:) }

    it 'deletes quote' do
      visit quote_path(quote)
      click_on 'Delete'
      expect(page).not_to have_content l(date.date, format: :long)
      expect(page).to have_content('Date was successfully destroyed.')
    end
  end
end
