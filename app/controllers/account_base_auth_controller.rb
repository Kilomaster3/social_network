class AccountBaseAuthController < ApplicationController
  before_action :authenticate_account!
end
