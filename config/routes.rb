# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :categories
    resources :products
    get 'top_products_by_category', to: 'reports#top_products_by_category'
    get 'top_revenue_products_by_category', to: 'reports#top_revenue_products_by_category'
    get 'purchases_by_parameters', to: 'reports#purchases_by_parameters'
    get 'purchase_count_by_granularity', to: 'reports#purchase_count_by_granularity'
  end
  # /admin/categories

  namespace :customer do
    get 'purchase', to: 'customer#purchase'
  end
  # /customer/test_customer
end
