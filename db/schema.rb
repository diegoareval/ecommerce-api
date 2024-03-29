# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_240_122_153_604) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'categories_products', id: false, force: :cascade do |t|
    t.bigint 'product_id', null: false
    t.bigint 'category_id', null: false
    t.index %w[category_id product_id], name: 'index_categories_products_on_category_id_and_product_id'
    t.index %w[product_id category_id], name: 'index_categories_products_on_product_id_and_category_id'
  end

  create_table 'images', force: :cascade do |t|
    t.string 'url'
    t.bigint 'product_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['product_id'], name: 'index_images_on_product_id'
  end

  create_table 'logs', force: :cascade do |t|
    t.string 'trackable_type', null: false
    t.bigint 'trackable_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[trackable_type trackable_id], name: 'index_logs_on_trackable'
    t.index ['user_id'], name: 'index_logs_on_user_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.text 'description'
    t.decimal 'price'
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_products_on_user_id'
  end

  create_table 'purchases', force: :cascade do |t|
    t.integer 'quantity'
    t.decimal 'total_amount'
    t.bigint 'product_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['product_id'], name: 'index_purchases_on_product_id'
    t.index ['user_id'], name: 'index_purchases_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'role'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'password_digest'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'images', 'products'
  add_foreign_key 'logs', 'users'
  add_foreign_key 'products', 'users'
  add_foreign_key 'purchases', 'products'
  add_foreign_key 'purchases', 'users'
end
