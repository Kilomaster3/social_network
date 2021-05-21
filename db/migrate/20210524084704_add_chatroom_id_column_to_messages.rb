# frozen_string_literal: true

class AddChatroomIdColumnToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :chatroom, null: false, foreign_key: true
  end
end
