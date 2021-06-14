# frozen_string_literal: true

module Accounts
  class ProfileController < AccountBaseAuthController
    def index
      @accounts = Account.where.not(id: current_account.id)
      authorize @accounts
    end

    def show
      @account = Account.find_by(id: params[:id])
      @interests_percentage = (@account.interests & current_account.interests).count.to_f / (@account.interests |
        current_account.interests).count * 100
    end

    def new
      @account = Account.new
    end

    def update
      if current_account.update(account_params)
        flash[:notice] = 'Profile complete'
        redirect_url = accounts_profile_path(current_account)
      else
        redirect_url = accounts_profile_path(current_account)
      end
      redirect_to redirect_url
    end

    def edit
      @account = Account.find(params[:id])
      authorize @account
    end

    def following
      @account = Account.find(params[:id])
      @accounts = @account.friends.paginate(page: params[:page], per_page: 6)
      render 'accounts/follows/show_friends'
    end

    def followers
      @account = Account.find(params[:id])
      @accounts = @account.followers_without_friend.paginate(page: params[:page], per_page: 6)
      render 'accounts/follows/show_followers'
    end

    private

      def account_params
        params.require(:account).permit(:email, :first_name, :last_name, :avatar, { interest_ids: [] },
                                        :interest_ids, :connection, :max_connection)
      end
  end
end
