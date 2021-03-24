class AddLastSeenToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :last_seen_at, :datetime
  end
end
