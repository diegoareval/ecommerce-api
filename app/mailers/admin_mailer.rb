# frozen_string_literal: true

class AdminMailer < ApplicationMailer
  def daily_purchase_report(report_data)
    @report_data = report_data
    mail(to: 'admin@example.com', subject: 'Daily Purchase Report')
  end
end
