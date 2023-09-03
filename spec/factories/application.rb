# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    job
    person
    score { rand(40..60) }
  end
end
