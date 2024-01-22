# frozen_string_literal: true

class ApplicationController < ActionController::API
  def require_admin!
    return if admin_signed_in?

    render json: { error: 'Unauthorized, you need admin roles to have access to this resource' },
           status: :unauthorized
  end

  def require_customer!
    return if customer_signed_in?

    render json: { error: 'Unauthorized, you need customer roles to have access to this resource' },
           status: :unauthorized
  end

  private

  def admin_signed_in?
    current_user&.admin?
  end

  def customer_signed_in?
    current_user&.customer?
  end
end
