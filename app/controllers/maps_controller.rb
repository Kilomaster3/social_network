class MapsController < ApplicationController
  def index
    gon.locations = Account.all
  end
end
