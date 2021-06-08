# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'social_network@network.com'
  layout 'mailer'
end
