# frozen_string_literal: true

class Purchase < ApplicationRecord
  after_create :send_first_purchase_notification

  belongs_to :product
  belongs_to :user

  scope :filter_by_date_range, lambda { |start_date, end_date|
                                 where(created_at: start_date..end_date) if start_date && end_date
                               }
  scope :filter_by_category, lambda { |category_id|
                               if category_id.present?
                                 joins(product: :categories).where(categories: { id: category_id })
                               end
                             }
  scope :filter_by_customer, ->(customer_id) { where(user_id: customer_id) if customer_id.present? }
  scope :filter_by_administrator, lambda { |admin_id|
                                    joins(product: :user).where(users: { id: admin_id }) if admin_id.present?
                                  }
  scope :count_by_granularity, lambda { |granularity|
                                 case granularity
                                 when 'hour'
                                   group("DATE_TRUNC('hour', purchases.created_at)")
                                 when 'day'
                                   group("DATE_TRUNC('day', purchases.created_at)")
                                 when 'week'
                                   group("DATE_TRUNC('week', purchases.created_at)")
                                 when 'year'
                                   group("DATE_TRUNC('year', purchases.created_at)")
                                 else
                                   all
                                 end
                               }

  def self.top_products_by_category
    category_counts = joins(:categories, :purchases)
                      .group('categories.id', 'products.id')
                      .order('categories.id', 'COUNT(purchases.id) DESC')
                      .pluck('categories.id', 'products.id', 'COUNT(purchases.id)')

    top_products_by_category = Hash.new { |hash, key| hash[key] = [] }

    category_counts.each do |category_id, product_id, purchase_count|
      top_products_by_category[category_id.to_i] << { product_id: product_id.to_i, purchase_count: purchase_count }
    end

    top_products_by_category
  end

  def send_first_purchase_notification
    product = self.product
    buyer = user

    return unless product.purchases.count == 1

    admins = User.where(role: 'admin')

    PurchaseMailer.first_purchase_notification(product, buyer).deliver_now

    admins.each do |admin|
      PurchaseMailer.first_purchase_notification(product, admin).deliver_now
    end
  end
end
