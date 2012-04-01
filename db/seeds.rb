users = []
categories = []

puts "Creating Users..."
5.times do
  users << FactoryGirl.create(:user)
end

puts "Creating Categories..."
25.times do
  categories << FactoryGirl.create(:category)
end

puts "Creating Bookmarks..."
50.times do
  FactoryGirl.create(:bookmark, :user => users.sample, :category => categories.sample)
end
