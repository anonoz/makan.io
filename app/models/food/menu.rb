class Food::Menu < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  monetize :base_price_cents
  
  belongs_to :food_category, class_name: "Food::Category"
  belongs_to :vendor_subvendor, class_name: "Vendor::Subvendor"

  has_many :menu_options, class_name: "Food::MenuOption"
  has_many :options, class_name: "Food::Option",
           through: :menu_options

  validates :food_category, presence: true
  validates :vendor_subvendor, presence: true
  validates :title, presence: true
  validates :base_price_cents, presence: true, numericality: true

  has_attached_file :feature_photo,
                    styles: {
                      medium: "280x210>",
                      thumb: "100x100>"
                    },
                    default_url: "/images/:style/dddddd.png"
                    
  validates_attachment_content_type :feature_photo,
                                    content_type: /\Aimage\/.*\Z/
end
