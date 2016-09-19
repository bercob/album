# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  crypted_password :string
#  salt             :string
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :user do
    factory :admin do
      email 'user@example.com'
      password 'user'
    end
  end
end
