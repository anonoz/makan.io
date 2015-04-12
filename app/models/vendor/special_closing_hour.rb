class Vendor::SpecialClosingHour < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :vendor_vendor, class_name: "Vendor::Vendor"

  validates :vendor_vendor, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true,
            time: { later_than: ->(closing_hour){ closing_hour.start_at } }
end
