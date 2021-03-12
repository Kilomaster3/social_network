class AddUniqueIndexToFriendship < ActiveRecord::Migration[6.0]
  def change
    add_index :friendships, %i[sent_to_id sent_by_id], unique: true
  end
end
