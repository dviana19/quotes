# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    name { 'default line item' }
    description { 'default description' }
    quantity { 3 }
    unit_price { 105 }
    association :line_item_date
  end
end
