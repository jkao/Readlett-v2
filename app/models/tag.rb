class Tag < ActiveRecord::Base
  has_and_belongs_to_many :bookmarks

  # Can treat attributes as symbols
  symbolize :code
  symbolize :name

  before_save :set_lower_case

  def latest_bookmarks
    self.bookmarks.order("id DESC")
  end

  private

  def set_lower_case
    self.code = self.code.downcase unless self.code.nil?
  end
end
