class Ability
  include CanCan::Ability

  def initialize(user)
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    user ||= User.new # guest user

    # use this if you get stuck:
    # if user.id == 1 #quick hack
    #   can :access, :all
    if user.role? :superadmin
      can :access, :all
    else
      # put restrictions for other users here
      can :slug, :pages
    end
  end
end
