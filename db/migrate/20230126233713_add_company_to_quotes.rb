# frozen_string_literal: true

class AddCompanyToQuotes < ActiveRecord::Migration[7.0]
  def change
    add_reference :quotes, :company, null: false, foreign_key: true
  end
end
