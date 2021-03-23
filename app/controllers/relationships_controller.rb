class RelationshipsController < AccountBaseAuthController
  def create
    @account = Account.find(params[:followed_id])
    current_account.follow(@account)
    respond_to do |format|
      format.html { redirect_to account_profile_path }
      format.js
    end
  end

  def destroy
    @account = Relationship.find(params[:id]).followed
    current_account.unfollow(@account)
    respond_to do |format|
      format.html { redirect_to account_profile_path }
      format.js
    end
  end
end
