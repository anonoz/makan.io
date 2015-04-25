class VendorAbility
  include CanCan::Ability

  def initialize(user)
    if user.permission_level >= 100
      can :manage, :all
    end

    if user.permission_level >= 80
      can :manage, Vendor::Subvendor, vendor_vendor_id: user.vendor_vendor_id
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
