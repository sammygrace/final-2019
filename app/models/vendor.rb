class Vendor < ApplicationRecord
  belongs_to :school, optional: true
  has_many :comments
  
  def self.search(keywords)
    keyword = "%#{keywords}%"
    self.where("name ilike ? or description ilike ?", keyword, keyword)
  end

end
