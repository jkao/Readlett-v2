FactoryGirl.define do
  factory :tag do
    name { Faker::Internet.domain_word }
    code { Faker::Internet.user_name }
  end

  factory :tag_with_many_bookmarks do
    after_build do |c|
      c.bookmarks << FactoryGirl.build(:bookmark)
    end
  end
end
