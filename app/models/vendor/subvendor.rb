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

  def order_items(from: Time.at(0), to: Date.today.end_of_day)
    if String === to
      to = if /^\d{4}-\d{2}-\d{2}$/.match(to)
        Date.parse(to).end_of_day
      else
        Time.zone.parse(to)
      end
    end

    order_chit_ids = vendor.order_chits.
      where(status: [:accepted, :delivered, :finished], created_at: from..to).
      pluck(:id)
    food_menu_ids = food_menus.pluck(:id)
    
    Order::Item.
      where(order_chit_id: order_chit_ids, orderable: food_menus)
  end

  def order_items_on(date)
    date = Date.parse(date) if String === date
    order_items(from: date.beginning_of_day, to: date.end_of_day)
  end

  def items_ordered(date_range = {})
    order_items(date_range).sum(:quantity) || 0
  end

  def items_ordered_on(date)
    date = Date.parse(date) if String === date
    items_ordered(from: date.beginning_of_day, to: date.end_of_day)
  end

  def amount_payable(date_range = {})
    order_items(date_range).collect(&:subvendor_payable).reduce(:+) || 0
  end

  def amount_payable_on(date)
    date = Date.parse(date) if String === date
    amount_payable(from: date.beginning_of_day, to: date.end_of_day)
  end

  private

  def check_if_no_food_menus
    unless food_menus.empty?
      errors.add :base, "still has food menus"
      return false
    end
  end
end
