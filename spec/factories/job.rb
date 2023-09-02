# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    company { Faker::Company.name }
    title { Faker::Job.title }
    description { "#{Faker::Job.employment_type} #{Faker::Job.key_skill} #{Faker::Job.seniority}" }
    location { ["A", "B", "C", "D", "E", "F"].sample }
    level { rand(1..5) }
  end
end
