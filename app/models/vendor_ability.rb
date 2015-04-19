class VendorAbility
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
    if user.permission_level >= 100
      can :manage, Vendor::User
    end

    if user.permission_level >= 80
      can :manage, Vendor::Subvendor
      can :manage, Place::Area
    end

    if user.permission_level >= 60
      can :manage, Food::Menu
      can :manage, Food::Category
      can :manage, Food::Option
      can :manage, Food::OptionChoice
    end

    if user.permission_level >= 40
      can :manage, Vendor::WeeklyOpeningHour
      can :manage, Vendor::SpecialClosingHour
      can :manage, Food::Menu
    end

    # can :manage, ::Order::Invoice
  end
end
