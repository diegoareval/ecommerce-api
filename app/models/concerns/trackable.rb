# frozen_string_literal: true

module Trackable
  extend ActiveSupport::Concern
  included do
    before_save :create_change_record
  end

  private

  def create_change_record
    changes.build(user: User.current_user) if User.current_user
  end
end
