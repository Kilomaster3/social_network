class OnlineChannel < ApplicationCable::Channel
  def subscribed
    ActionCable.server.pubsub.redis_connection_for_subscriptions.sadd 'online', current_account.id

    stream_from 'online:account'

    html = ApplicationController.render(partial: 'account/online', locals: { account: current_account })
    broadcast_to 'accounts', { id: current_account.id, status: 'online', html: html }
  end

  def unsubscribed
    ActionCable.server.pubsub.redis_connection_for_subscriptions.srem 'online', current_account.id

    broadcast_to 'accounts', { id: current_account.id, status: 'offline' }
  end
end
