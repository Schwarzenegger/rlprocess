class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?  # additional permissions for administrators
      can :manage, :all
    elsif user.manager?
      can [:manage], [Client, MasterActivity, ActivityProfile]
    end
  end
end
