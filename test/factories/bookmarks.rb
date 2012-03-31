FactoryGirl.define do
  factory :bookmark do
    title { Faker::Company.name }
    description { Faker::Company.bs }
    link { "http://#{Faker::Internet.domain_name}" }
    disqus_uuid { UUID.generate(:compact) }
    views 0
    nsfw false
    after_build do |b|
      b.category ||= FactoryGirl.build(:category)
      b.user ||= FactoryGirl.build(:user)
      b.private = false
    end
  end
end
