# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :products
  has_many :purchases

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :role, presence: true
  enum role: { customer: 'customer', admin: 'admin' }

  class << self
    attr_accessor :current_user
  end
end
