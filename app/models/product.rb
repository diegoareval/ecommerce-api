# frozen_string_literal: true

class Product < ApplicationRecord
  include Trackable

  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :images, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :logs, as: :trackable, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_save :create_change_record

  def self.top_revenue_products_by_category
    category_revenue = joins(:categories, purchases: :user)
                       .group('categories.id', 'products.id')
                       .order('categories.id', 'SUM(purchases.quantity * products.price) DESC')
                       .pluck('categories.id', 'products.id', 'SUM(purchases.quantity * products.price)')

    top_products_by_category = {}

    category_revenue.each do |category_id, product_id, revenue|
      top_products_by_category[category_id.to_i] ||= []
      top_products_by_category[category_id.to_i] << { product_id: product_id.to_i, revenue: revenue.to_f }
    end

    top_products_by_category.transform_values! { |products| products.take(3) }
  end
end
