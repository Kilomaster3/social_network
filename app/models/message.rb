# frozen_string_literal: true

class Message < ApplicationRecord
  include CableReady::Broadcaster
  validates :body, presence: true
  belongs_to :chatroom
  belongs_to :account

  def broadcast
    cable_ready['chat_channel'].insert_adjacent_html(
      selector: '.chat',
      position: 'afterbegin',
      html: "<class = 'row no-gutters' class='col' class='message-content'>
              <p class='mb-1'>#{body}</p>
            </a>"
    )

    cable_ready.broadcast
  end
end
