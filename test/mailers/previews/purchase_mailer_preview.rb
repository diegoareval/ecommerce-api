# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/purchase_mailer
class PurchaseMailerPreview < ActionMailer::Preview
  def first_purchase_notification
    product = Product.first
    user = User.first
    PurchaseMailer.first_purchase_notification(product, user)
  end
end
