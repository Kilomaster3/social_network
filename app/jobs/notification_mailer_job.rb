class NotificationMailerJob < ApplicationJob
  queue_as :default

  def perform
    Account.last_seen.ids.each do |account_id|
      NotificationMailer.week_info(account_id).deliver_later
    end
  end
end
