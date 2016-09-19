FactoryGirl.define do
  factory :user do
    factory :admin do
      email 'user@example.com'
      password 'user'
    end
  end
end
