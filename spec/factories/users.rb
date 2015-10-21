FactoryGirl.define do
    factory :user do
        name 'John'
        surname 'Smith'
        sequence(:email){|n| "abc123#{n}@gmail.com"}
        password '12345678'
        bithday '1991-01-01'
        address 'melbourne'
        role 'user'
  end
end
  