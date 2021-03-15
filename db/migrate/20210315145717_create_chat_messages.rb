class CreateChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_messages do |t|
      t.references :message, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
