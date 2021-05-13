# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def week_info(account_id)
    @account = Account.find(account_id)
    @posts = Post.where('created_at >= ?', 2.days.ago.utc).where('account_id in (?) ', @account.followers.pluck(:id))
    mail(to: @account.email, subject: 'Weekly Update!')
  end
end
