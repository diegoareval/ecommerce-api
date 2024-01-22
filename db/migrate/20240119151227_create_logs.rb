# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :logs do |t|
      t.references :trackable, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
