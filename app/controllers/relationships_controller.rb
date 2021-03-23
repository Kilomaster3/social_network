class RelationshipsController < AccountBaseAuthController
  def create
    @account = Account.find(params[:followed_id])
    @accounts = Account.where.not(id: current_account.id)
    current_account.follow(@account)
    respond_to do |format|
      format.html { redirect_to @account }
      format.js
    end
  end

  def destroy
    @account = Relationship.find(params[:id]).followed
    @accounts = Account.where.not(id: current_account.id)
    current_account.unfollow(@account)
    respond_to do |format|
      format.html { redirect_to @account }
      format.js
    end
  end
end
