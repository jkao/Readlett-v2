FactoryGirl.define do
  factory :category do
    name { Faker::Internet.domain_word }
    after_build do |b|
      b.code = Faker::Internet.user_name.upcase!
    end
  end
end
