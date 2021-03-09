module FriendshipsHelper
  def friend_request_sent?
    current_account.friend_sent.exists?(sent_to_id: @account.id, status: false)
  end

  def friend_request_received?
    current_account.friend_request.exists?(sent_by_id: @account.id, status: false)
  end

  def possible_friend?(account)
    request_sent = current_account.friend_sent.exists?(sent_to_id: account.id)
    request_received = current_account.friend_request.exists?(sent_by_id: account.id)

    return if request_sent != request_received
    return if request_sent == request_received && request_sent

    request_sent != request_received || request_sent
  end
end
