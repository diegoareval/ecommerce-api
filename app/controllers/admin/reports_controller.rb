# frozen_string_literal: true

module Admin
  class ReportsController < ApplicationController
    before_action :require_admin!
    def top_products_by_category
      @top_products_by_category = TopProductsByCategoryService.call
      render json: @top_products_by_category
    end

    def top_revenue_products_by_category
      @top_revenue_products_by_category = Product.top_revenue_products_by_category
      render json: @top_revenue_products_by_category
    end

    def purchases_by_parameters
      start_date = params[:start_date]
      end_date = params[:end_date]
      category_id = params[:category_id]
      customer_id = params[:customer_id]
      admin_id = params[:admin_id]

      @purchases = Purchase.filter_by_date_range(start_date, end_date)
                           .filter_by_category(category_id)
                           .filter_by_customer(customer_id)
                           .filter_by_administrator(admin_id)
      render json: @purchases
    end

    def purchase_count_by_granularity
      @purchase_counts = Purchase.filter_by_params(purchase_params)
                                 .count_by_granularity(purchase_params[:granularity])
                                 .count

      render json: @purchase_counts
    end

    private

    def purchase_params
      params.permit(:start_date, :end_date, :category_id, :customer_id, :admin_id, :granularity)
    end
  end
end
