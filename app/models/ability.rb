class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?  # additional permissions for administrators
      can :manage, :all
    end
  end
end
