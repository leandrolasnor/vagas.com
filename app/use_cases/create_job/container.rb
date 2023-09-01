# frozen_string_literal: true

class CreateJob::Container
  include Dry::Container::Mixin

  register 'steps.validate', -> { ::Steps::Validate.new }
  register 'steps.create', -> { ::Steps::Create.new }
end
