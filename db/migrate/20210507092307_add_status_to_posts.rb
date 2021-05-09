# frozen_string_literal: true

class AddStatusToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :status, :string
  end
end
