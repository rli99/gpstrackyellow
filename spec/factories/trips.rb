FactoryGirl.define do
    factory :trip do
        avgSpeed "8km/h"
        duration "2h"
        distance "16km"
        verified false
        association :user
    end
end