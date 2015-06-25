class Vendor::Subvendor < ActiveRecord::Base
  FKEY = "vendor_subvendor_id"

  include OpeningTimeable
  extend Enumerize
  acts_as_paranoid
  enumerize :city, in: {setapak: 1}, default: :setapak, scope: :in_city

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_destroy :check_if_no_food_menus
  
  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"
  alias_method :vendor, :vendor_vendor

  has_many :food_menus, class_name: "Food::Menu", foreign_key: FKEY
  has_many :weekly_opening_hours, class_name: "Vendor::WeeklyOpeningHour",
           foreign_key: FKEY
  has_many :special_closing_hours, class_name: "Vendor::SpecialClosingHour",
           foreign_key: FKEY

  validates :vendor_vendor, presence: true
  validates :city, presence: true

  def order_items(from: Time.at(0), to: Time.now)
    if String === from && String === to
      from, to = Time.zone.parse(from), Time.zone.parse(to)
    end

    order_chit_ids = vendor.order_chits.
      where(status: [:accepted, :delivered, :finished], created_at: from..to).
      pluck(:id)
    food_menu_ids = food_menus.pluck(:id)
    
    Order::Item.where(order_chit_id: order_chit_ids, food_menu_id: food_menu_ids)
  end

  def items_ordered
    order_items.sum(:quantity) || 0
  end

  def amount_payable(date_range = {})
    order_items(date_range).collect(&:subvendor_payable).reduce(:+) || 0
  end

  private

  def check_if_no_food_menus
    unless food_menus.empty?
      errors.add :base, "still has food menus"
      return false
    end
  end
end
