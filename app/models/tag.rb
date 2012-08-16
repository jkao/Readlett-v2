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

  def self.create_or_use_unique_tag(tag_name)
    # Clean up the String
    tag_name.strip!
    tag_name.downcase!

    # Grab the Tag or Make it
    existing_tag = Tag.where(:name => tag_name).first
    existing_tag.nil? ? Tag.create(:name => tag_name, :code => UUID.generate(:compact)) : existing_tag
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
