class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :name

      t.timestamps
    end
    add_index :messages, :name, unique: true
  end
end
