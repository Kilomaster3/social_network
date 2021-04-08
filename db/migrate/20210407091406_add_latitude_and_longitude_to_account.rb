class AddLatitudeAndLongitudeToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :latitude, :float
    add_column :accounts, :longitude, :float
  end
end
