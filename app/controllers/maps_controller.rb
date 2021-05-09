# frozen_string_literal: true

class MapsController < AccountBaseAuthController
  def index
    gon.locations = Account.all
  end
end
