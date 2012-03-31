FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    url { "http://#{Faker::Internet.domain_name}" }
    description { Faker::Company.bs }
    disqus_uuid { UUID.generate(:compact) }
  end
end
