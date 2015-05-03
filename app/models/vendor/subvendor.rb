class Vendor::Subvendor < ActiveRecord::Base
  FKEY = "vendor_subvendor_id"

  include OpeningTimeable
  extend Enumerize
  acts_as_paranoid
  enumerize :city, in: {setapak: 1}, default: :setapak, scope: :in_city

  before_destroy :check_if_no_food_menus
  
  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  has_many :food_menus, class_name: "Food::Menu",
           foreign_key: "vendor_subvendor_id"
  has_many :weekly_opening_hours, class_name: "Vendor::WeeklyOpeningHour",
           foreign_key: "vendor_subvendor_id"
  has_many :special_closing_hours, class_name: "Vendor::SpecialClosingHour",
           foreign_key: "vendor_subvendor_id"

  validates :vendor_vendor, presence: true
  validates :city, presence: true

  def check_if_no_food_menus
    unless food_menus.empty?
      errors.add :base, "still has food menus"
      return false
    end
  end

  def closure_reason
    if normally_closed?
      "normally closed"
    elsif specially_closed?
      "specially closed"
    else
      # This isn't supposed to happen
      raise CurrentlyOpenYouIdiot,
            subvendor_id: id, subvendor_title: title
    end
  end

  class CurrentlyOpenYouIdiot < StandardError; end
end
