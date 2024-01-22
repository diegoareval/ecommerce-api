# frozen_string_literal: true

class DailyPurchaseReportWorker
  include Sidekiq::Worker

  def perform
    start_date = 1.day.ago.beginning_of_day
    end_date = Time.current.beginning_of_day

    purchases = Purchase.includes(:product).where(created_at: start_date..end_date)
    report_data = generate_report_data(purchases)

    AdminMailer.daily_purchase_report(report_data).deliver_now
  end

  private

  def generate_report_data(purchases)
    purchases_by_product = purchases.group_by(&:product)

    # Format the data for the email
    formatted_data = purchases_by_product.map do |product, purchases|
      {
        product_name: product.name,
        total_purchases: purchases.size,
        total_amount: purchases.sum(&:total_amount)
      }
    end

    { purchases: formatted_data }
  end
end
