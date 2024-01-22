# frozen_string_literal: true

require 'faker'

# Clear existing data
puts 'Clearing existing data...'
Product.destroy_all
Category.destroy_all
User.destroy_all
Purchase.destroy_all

# generate customer users
5.times do
  customer_user_params = {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password',
    role: 'customer'
  }

  User.create(customer_user_params)
end

# Create a default user/admin for seeding products
admin_user = User.create(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'admin'
)

# Seed Categories
categories = 5.times.map do
  Category.create(
    name: Faker::Commerce.department(max: 1, fixed_amount: true)
  )
end

# Seed Products with associated Images and Categories
products = []
10.times do
  product_params = {
    name: Faker::Commerce.product_name,
    price: Faker::Commerce.price,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    user: admin_user
  }

  product = Product.new(product_params)

  # Associate with Categories
  product.categories << categories.sample(rand(1..3))

  product.save

  # Seed Images for the product
  3.times do
    product.images.create(
      url: Faker::Placeholdit.image(size: '300x300', format: 'jpg')
    )
  end

  products << product
end

# Seed Purchases
customer_user = User.create(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: 'password',
  role: 'customer'
)

products.each do |product|
  purchase_params = {
    quantity: rand(1..5),
    total_amount: product.price * rand(1..5),
    product: product,
    user: customer_user
  }

  Purchase.create(purchase_params)
end

puts 'Seeding complete.'
