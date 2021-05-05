class Admin::AccountsController < AccountBaseAuthController
  def index
    @accounts = Account.includes([:interests]).all
    authorize @accounts
  end
end
