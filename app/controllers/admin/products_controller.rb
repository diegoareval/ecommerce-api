# frozen_string_literal: true

module Admin
  class ProductsController < ApplicationController
    before_action :require_admin!
    before_action :set_product, only: %i[show update destroy]

    def index
      render json: Product.all
    end

    def show
      render json: @product
    end

    def create
      @product = current_user.products.new(product_params)

      if @product.save
        create_images if params.dig(:product, :images).present?
        render json: @product, status: :created
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(product_params)
        render json: @product
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @product.destroy
      head :no_content
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, category_ids: [], images: [:url])
    end

    def create_images
      @product.images.create(params[:product][:images])
    end
  end
end
