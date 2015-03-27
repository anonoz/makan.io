class Vendor::Vendor < ActiveRecord::Base
  validates :title, presence: true
end
