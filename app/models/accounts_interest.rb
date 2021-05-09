# frozen_string_literal: true

class AccountsInterest < ApplicationRecord
  belongs_to :interest
  belongs_to :account
end
