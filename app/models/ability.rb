class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all
    return if user.new_record?

    can :manage, [Post, Comment], author_id: user.id
    return unless user.admin?

    can :manage, :all
  end
end
