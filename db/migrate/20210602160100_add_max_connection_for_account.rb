# frozen_string_literal: true

class AddMaxConnectionForAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :max_connection, :integer, foreign_key: true
  end
end
