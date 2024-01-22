# frozen_string_literal: true

class CreatePurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :purchases do |t|
      t.integer :quantity
      t.decimal :total_amount
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
