class Admin::AccountsController < AccountBaseAuthController
  def index
    @accounts = Account.all
  end
end
