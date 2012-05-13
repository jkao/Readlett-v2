class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  validates_presence_of :code, :name

  # Can treat attributes as symbols
  symbolize :code
  symbolize :name

  before_validation :set_lower_case

  def self.get_popular
    self.order("id DESC")
  end

  def latest_bookmarks
    self.bookmarks.order("id DESC")
  end

  private

  def set_lower_case
    self.code = self.code.to_s.downcase
    self.name = self.name.to_s.downcase
  end

end
