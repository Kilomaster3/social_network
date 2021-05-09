# frozen_string_literal: true

class AddCategoriesRefToInterests < ActiveRecord::Migration[6.0]
  def change
    add_reference :interests, :category, foreign_key: true
  end
end
