class Food::Menu < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail
  monetize :base_price_cents
  
  belongs_to :food_category, class_name: "Food::Category"
  belongs_to :vendor_subvendor, class_name: "Vendor::Subvendor"
  alias_method :subvendor, :vendor_subvendor

  has_many :food_menu_options, class_name: "Food::MenuOption",
           foreign_key: "food_menu_id"
  has_many :food_options, class_name: "Food::Option",
           through: :food_menu_options
  has_many :food_allergy_tags, class_name: "Food::AllergyTag",
           foreign_key: "food_menu_id"
  has_many :food_allergens, through: :food_allergy_tags

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

  def available?
    subvendor.open? && availability
  end
end
