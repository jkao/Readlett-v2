FactoryGirl.define do
  factory :bookmark do
    title { Faker::Company.name }
    description { Faker::Company.bs }
    link { "http://#{Faker::Internet.domain_name}" }
    disqus_uuid { UUID.generate(:compact) }
    views 0
    nsfw false
    after_build do |b|
      b.user ||= FactoryGirl.build(:user)
      b.private = false
    end
  end

  factory :bookmark_with_tags, :parent => :bookmark do
    after_build do |b|
      3.times do
        b.tags << FactoryGirl.build(:tag)
      end
    end
  end
end
