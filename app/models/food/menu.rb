class Food::Menu < ActiveRecord::Base
  acts_as_paranoid
  has_paper_trail ignore: [:availability]
  monetize :base_price_cents
  monetize :subvendor_price_cents

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  
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
  has_many :order_items, as: :orderable

  validates :food_category, presence: true
  validates :vendor_subvendor, presence: true
  validates :title, presence: true
  validates :base_price_cents, presence: true, numericality: true
  validates :code, uniqueness: true, allow_blank: true

  has_attached_file :feature_photo,
                    styles: {
                      medium: "280x210>",
                      thumb: "100x100>"
                    },
                    default_url: "/images/:style/dddddd.png"
                    
  validates_attachment_content_type :feature_photo,
                                    content_type: /\Aimage\/.*\Z/
  
  def to_s
    title
  end

  def available?
    subvendor.open? && availability
  end

  def unavailability_reason
    if availability == false
      return "temporarily unavailable"
    end

    if subvendor.closed?
      return "subvendor #{ subvendor.closure_reason }"
    end
  end

  private

  def slug_candidates
    [
      [:code, :title]
    ]
  end
end
