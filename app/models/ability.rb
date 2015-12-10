class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Member.new(role: nil)
    alias_action :create, :read, :update, :destroy, to: :crud

    if user.admin?
      can :read, :all
      can :manage, Member
      can [:crud], [Ad, Comment], member_id: user.id
      can :destroy,  Comment
    elsif user.moderator?
      can :read, :all
      can :manage, [ Ad, Comment]
      can :update, Member, :id => user.id
    elsif user.user?
      can :read, :all
      can [:crud], [Ad, Comment], member_id: user.id
      can :update, Member, id: user.id
    elsif user.role.nil?      
      can :read, :all
      can :create, Member
      cannot :index, Member
    end
  end

end
