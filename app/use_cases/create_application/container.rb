# frozen_string_literal: true

class CreateApplication::Container
  extend Dry::Container::Mixin

  register 'steps.validate', -> { CreateApplication::Steps::Validate.new }
  register 'steps.create', -> { CreateApplication::Steps::Create.new }
end
