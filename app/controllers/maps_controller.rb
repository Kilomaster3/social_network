class MapsController < AccountBaseAuthController
  def index
    gon.locations = Account.all
  end
end
