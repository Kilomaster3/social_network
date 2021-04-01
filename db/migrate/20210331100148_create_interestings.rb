class CreateInterestings < ActiveRecord::Migration[6.0]
  def change
    create_table :interestings do |t|
      t.belongs_to :interest, null: false, foreign_key: true
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
