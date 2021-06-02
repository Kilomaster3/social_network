class AddParentToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :parent_id, :integer, foreign_key: true
  end
end
