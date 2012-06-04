FactoryGirl.define do
  factory :identity do
    name 'test'
    sequence (:email) {|n| "test+#{n}@test.com"}
    password 'jjjjjj'
    password_confirmation { |u| u.password }
    street_address "street"
    city "city"
    state "state"
    zip "zip"
    home_phone "123456"
    cell "0123456789"
    package "3"
    referer_id "1"
  end

  factory :user do
    #name
    #email
    #uid
    provider 'identity'
    package "3"
    #referred_by "user-1"
    referer_id "1"

    company "company"
    spouse_name "spouse"
    street_address "street"
    city "city"
    state "state"
    zip "zip"
    ein "ein"
    home_phone "123456"
    cell "0123456789"
  end
end
