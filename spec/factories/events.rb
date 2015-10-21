FactoryGirl.define do
    factory :event do
        transportation "walking"
        association :trip
    end
end