# frozen_string_literal: true

class CreateApplication::Container
  extend Dry::Container::Mixin

  register 'steps.validate', -> { ::Steps::Validate.new }
  register 'steps.create', -> { ::Steps::Create.new }
  register 'steps.calculate_score', -> { ::Steps::CalculateScore.new }
end
