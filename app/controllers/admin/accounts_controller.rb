class Admin::AccountsController < AccountBaseAuthController
  def index
    @accounts = Account.paginate(page: params[:page], per_page: 4).includes([:interests]).all
    authorize @accounts
  end
end
