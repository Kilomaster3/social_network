# frozen_string_literal: true

class AddDirectMessageToChatrooms < ActiveRecord::Migration[6.0]
  def change
    add_column :chatrooms, :direct_message, :boolean, default: false
  end
end
