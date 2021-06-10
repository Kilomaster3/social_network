# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def week_info(account_id)
    @account = Account.find(account_id)
    @posts = Post.where(created_at: (Time.current - 7.days)..Time.current).joins(:likes).group('posts.id')
                 .order('count(likes.id) desc').limit(4)
    @requests_to_friends = @account.followers.where(created_at: (Time.current - 7.days)..Time.current)
    mail(to: @account.email, subject: 'Weekly Update!')
  end
end
