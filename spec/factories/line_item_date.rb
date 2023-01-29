# frozen_string_literal: true

FactoryBot.define do
  factory :line_item_date do
    date { Time.zone.today }
    association :quote
  end
end
