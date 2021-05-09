# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :account, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
