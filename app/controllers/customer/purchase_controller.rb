# frozen_string_literal: true

module Customer
  class CustomerController < ApplicationController
    # only buy if the user is authenticated no matter the role (but i have a require customer helper)
    before_action :authenticated_user!

    def purchase
      @purchase = Purchase.new(purchase_params)
      @purchase.user_id = current_user.id

      if @purchase.save
        calculate_total_amount
        render json: @purchase, status: :created
      else
        render json: { errors: @purchase.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def purchase_params
      params.require(:purchase).permit(:quantity, :product_id)
    end

    def calculate_total_amount
      product = @purchase.product
      @purchase.update(total_amount: product.price * @purchase.quantity)
    end
  end
end
