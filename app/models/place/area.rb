class Place::Area < ActiveRecord::Base
  extend Enumerize
  enumerize :city, in: {setapak: 1}, default: :setapak, scope: :in_city
  enumerize :zone, in: {
    danau_kota:    101,
    wangsa_maju:   102,
    sri_rampai:    103,
    genting_klang: 104
  }, default: :danau_kota, scope: :in_zone

  acts_as_paranoid
  
  validates :name, presence: true
  validates :city, presence: true
end
