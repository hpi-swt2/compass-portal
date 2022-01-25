FactoryBot.define do
  factory :event do

    d_start { "2022-01-12 10:58:13" }
    d_end { "2022-01-12 11:58:13" }

    trait :in_one_hour do
      name { "Future Event" }
      d_start { 1.hour.from_now }
      d_end { 2.hours.from_now }
    end

    trait :right_now do
      name { "Current Event" }
      d_start { 30.minutes.ago }
      d_end { 30.minutes.from_now }
    end

    name { "Test event in room 1" }
    description do
      "This event is incredible and a lot of people are going to be there. But sice there is still a pandemic going aroud, please all wear masks."
    end
    recurring do
      "---
      :validations: {}
      :rule_type: IceCube::DailyRule
      :interval: 1"
    end

  end
end
