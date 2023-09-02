# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    job
    person
    score { ["100", "75", "50", "25", "0"].sample.to_i }
  end
end
