class Vendor < ApplicationRecord
  belongs_to :school, optional: true
  has_many :comments
  
  geocoded_by :address
  after_validation :geocode

  def self.search(keywords)
    keyword = "%#{keywords}%"
    self.where("name ilike ? or description ilike ?", keyword, keyword)
  end

  def self.geosearch(location)
    location = "%#{location}%"
    self.near(location, 100)
  end

end
