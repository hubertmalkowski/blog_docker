
class UserPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def allowed?
    user.admin?
  end

end
