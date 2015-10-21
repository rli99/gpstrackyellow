FactoryGirl.define do
    factory :intermediatepoint do
        time Time.new
        latitude "-37.79025"
        longitude "145.0415"
        altitude "333"
        association :event
    end
end