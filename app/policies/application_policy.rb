class ApplicationPolicy
  attr_reader :account, :record

  def initialize(account, record)
    @account = account
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def belongs_to_account?
    post.account == account
  end

  def owner?
    account && account == record
  end

  def post
    record
  end

  class Scope
    attr_reader :account, :scope

    def initialize(account, scope)
      @account = account
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
