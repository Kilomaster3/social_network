module DashboardHelper
  def current_account?(account)
    account && account == current_account
  end
end
