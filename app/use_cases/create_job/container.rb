# frozen_string_literal: true

class CreateJob::Container
  extend Dry::Container::Mixin

  register 'steps.validate', -> { CreateJob::Steps::Validate.new }
  register 'steps.create', -> { CreateJob::Steps::Create.new }
end
