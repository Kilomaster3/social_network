# frozen_string_literal: true

class AddAccountForComments < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :account, foreign_key: true
  end
end
