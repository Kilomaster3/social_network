class Admin::AccountsController < AccountBaseAuthController
  def index
    @accounts = Account.all
    authorize @accounts
  end
end
