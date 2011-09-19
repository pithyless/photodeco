class Ability
  include CanCan::Ability

  def initialize(user)
    unless user
      guest_permits
    else
      @user = user
      if user.admin?
        admin_permits
      else
        user_permits
      end
    end
  end

  def guest_permits
    can :create, User
  end

  def user_permits
    can :read,   User, :id => @user.id
    can :update, User, :id => @user.id
  end

  def admin_permits
    can :manage, :all
  end
end
