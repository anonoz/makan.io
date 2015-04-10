class Vendor::User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :vendor, class_name: "Vendor::Vendor",
             foreign_key: "vendor_vendor_id"

  validates :vendor, presence: true
end
