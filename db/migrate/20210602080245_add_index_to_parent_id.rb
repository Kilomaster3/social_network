class AddIndexToParentId < ActiveRecord::Migration[6.0]
  def change
    add_index :comments, :parent_id
  end
end
