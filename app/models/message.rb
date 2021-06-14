# frozen_string_literal: true

class Message < ApplicationRecord
  include CableReady::Broadcaster
  validates :body, presence: true
  belongs_to :chatroom
  belongs_to :account

  def broadcast
    cable_ready['chat_channel'].insert_adjacent_html(
      selector: '.chat',
      position: 'beforeend',
      html: <<~HTML
        <div class="chat-message-container">
          <div class="row no-gutters">
            <div class="col">
              <div class="message-content">
                <p class="mb-1">
                  #{body}
                </p>
                <div class="text-right">
                <small>
                  #{account.full_name}
                </small>
                </div>
              </div>
            </div>
          </div>
        </div>
      HTML
    )

    cable_ready.broadcast
  end
end
