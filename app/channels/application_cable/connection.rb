# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_account

    def connect
      self.current_account = find_verified_account
      logger.add_tags 'Action Cable', "Account #{current_account.id}"
    end

    private

      def find_verified_account
        if (current_account = env['warden'].user)
          current_account
        else
          reject_unauthorized_connection
        end
      end
  end
end
