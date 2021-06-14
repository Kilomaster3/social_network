# frozen_string_literal: true

class AddConfirmableToDevise < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/SkipsModelValidations
  def up
    add_column :accounts, :confirmation_token, :string
    add_column :accounts, :confirmed_at, :datetime
    add_column :accounts, :confirmation_sent_at, :datetime
    add_index :accounts, :confirmation_token, unique: true
    Account.update_all confirmed_at: DateTime.now
  end
  # rubocop:enable Rails/SkipsModelValidations
end
