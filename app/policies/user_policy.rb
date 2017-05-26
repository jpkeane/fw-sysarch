class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    true
  end

  def edit?
    @user == @record
  end

  def update?
    edit?
  end

  def change_password?
    edit?
  end

  def update_password?
    edit?
  end
end
