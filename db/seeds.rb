users = []
categories = []

puts "Creating Users..."
5.times do
  users << FactoryGirl.create(:user)
end

puts "Creating Bookmarks..."
50.times do
  FactoryGirl.create(:bookmark, :user => users.sample)
end
