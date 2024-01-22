# frozen_string_literal: true

class PurchaseMailer < ApplicationMailer
  def first_purchase_notification(product, user)
    @product = product
    @user = user
    mail(to: user.email, subject: 'First Purchase Notification')
  end
end
