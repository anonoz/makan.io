class Vendor::SpecialClosingHour < ActiveRecord::Base
  acts_as_paranoid

  default_scope { where("end_at > ?", Time.now).order(end_at: :desc) }
  
  belongs_to :vendor_subvendor, class_name: "Vendor::Subvendor"
  alias_method :subvendor, :vendor_subvendor

  validates :vendor_subvendor, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true,
            time: { later_than: ->(closing_hour){ closing_hour.start_at } }
end
