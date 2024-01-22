# frozen_string_literal: true

class CreateJoinTableProductsCategories < ActiveRecord::Migration[6.1]
  def change
    create_join_table :products, :categories do |t|
      t.index %i[product_id category_id]
      t.index %i[category_id product_id]
    end
  end
end
