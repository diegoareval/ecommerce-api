# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def daily_purchase_report
    purchases = Purchase.includes(:product).limit(5)
    report_data = generate_report_data(purchases)
    AdminMailer.daily_purchase_report(report_data)
  end

  private

  def generate_report_data(purchases)
    formatted_data = purchases.map do |purchase|
      {
        product_name: purchase.product.name,
        total_purchases: 1,  # Adjust as needed
        total_amount: purchase.total_amount
      }
    end

    { purchases: formatted_data }
  end
end
