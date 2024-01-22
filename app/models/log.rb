# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :trackable, polymorphic: true
  belongs_to :user
end
