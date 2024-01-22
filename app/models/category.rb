# frozen_string_literal: true

class Category < ApplicationRecord
  include Trackable

  has_and_belongs_to_many :products
  has_many :logs, as: :trackable, dependent: :destroy
  validates :name, presence: true

  before_save :create_change_record
end
