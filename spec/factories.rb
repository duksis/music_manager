require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name 'Hugo'
    password 'welcome1'
    password_confirmation 'welcome1'
  end
end
