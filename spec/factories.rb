require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name 'Hugo'
    password 'welcome1'
    password_confirmation 'welcome1'
  end

  factory :album do
    artist 'Kings Of Leon'
    title 'Only By The Night'
    genre 'Rock'
    year '2008'
    number_of_tracks '6'
    number_of_discs '1'
  end
end
