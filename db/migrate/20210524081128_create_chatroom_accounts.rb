# frozen_string_literal: true

class CreateChatroomAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :chatroom_accounts do |t|
      t.references :chatroom, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
