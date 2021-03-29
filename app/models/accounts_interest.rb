class AccountsInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :account
end
