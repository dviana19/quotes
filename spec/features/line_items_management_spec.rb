# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'line items management', type: :feature do
  let(:company) { create(:company) }
  let(:user) { create(:user, email: 'user@example.com', company:) }
  let(:quote) { create(:quote, name: 'A quote example', company:) }
  let!(:line_item_date) { create(:line_item_date, quote:) }

  before { sign_in(user) }

  context 'when listing line items from a date' do
    let!(:line_item) { create(:line_item, unit_price: 55, quantity: 2, line_item_date:) }

    it 'lists all items' do
      visit quote_path(quote)
      expect(page).to have_content line_item.name
      expect(page).to have_content '$110.00'
    end
  end

  it 'creates line item' do
    visit quote_path(quote)
    click_on 'Add item'
    within('form#new_line_item') do
      fill_in 'line_item[name]', with: 'a basic name'
      fill_in 'line_item[description]', with: 'a basic description'
      fill_in 'line_item[quantity]', with: 5
      fill_in 'line_item[unit_price]', with: 92
    end
    click_on 'Create item'
    expect(page).to have_content '$460.00'
    expect(page).to have_content 'Item was successfully created.'
  end

  context 'when editing a line item' do
    let!(:line_item) { create(:line_item, quantity: 1, unit_price: 20, line_item_date:) }

    it 'edits line item' do
      visit quote_path(quote)
      within("#line_item_#{line_item.id}") do
        click_on 'Edit'
      end
      within("form#edit_line_item_#{line_item.id}") do
        fill_in 'line_item[quantity]', with: 5
      end
      click_on 'Update item'
      expect(page).to have_content '$100.00'
      expect(page).to have_content 'Item was successfully updated.'
    end
  end

  context 'when deleting a date' do
    let!(:line_item) { create(:line_item, line_item_date:) }

    it 'deletes quote' do
      visit quote_path(quote)
      within("#line_item_#{line_item.id}") do
        click_on 'Delete'
      end
      expect(page).to have_content '$0.00'
      expect(page).to have_content 'Item was successfully destroyed.'
    end
  end
end
