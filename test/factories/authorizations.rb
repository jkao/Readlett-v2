FactoryGirl.define do
  factory :authorization do
    user
    provider { ["google", "facebook"].sample }
    uid { UUID.generate(:compact) }

    after_build do |a|
      a.user ||= FactoryGirl.build(:user)
    end
  end
end
