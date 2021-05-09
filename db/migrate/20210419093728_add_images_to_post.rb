# frozen_string_literal: true

class AddImagesToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :image, :string
  end
end
