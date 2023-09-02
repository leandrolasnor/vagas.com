# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    name { Faker::FunnyName.name }
    profession { "#{Faker::Job.position} #{Faker::Job.seniority}" }
    location { ["A", "B", "C", "D", "E", "F"].sample }
    level { rand(1..5) }
  end
end
