FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password "password"
    name "Bob"
    title "RoR"
  end

  factory :company do
    organization "Google"
    state "CO"
    city "Denver"
    hiring 1
    hire_count 5
    name "John"
    title "RoR Developer"
    email "john@example.com"
    status "uncontacted"

    transient do
      user_count 2
    end

    after(:create) do |company, evaluator|
      create_list(:user, evaluator.user_count, company: company)
    end
  end
end
