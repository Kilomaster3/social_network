# frozen_string_literal: true

class AddConnectionForAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :connection, :integer, foreign_key: true
  end
end
