# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    score { rand(40..60) }

    trait :calculate_score do
      job factory: %i[job calculate_score]
      person factory: %i[person calculate_score]
      initialize_with { CalculateScore::Model::Application.new(attributes) }
    end

    trait :create_application do
      job factory: %i[job create_application]
      person factory: %i[person create_application]
      initialize_with { CreateApplication::Model::Application.new(attributes) }
    end
  end
end
