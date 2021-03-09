class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :sent_to, null: false, foreign_key: { to_table: :accounts }
      t.references :sent_by, null: false, foreign_key: { to_table: :accounts }
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
