# frozen_string_literal: true

class CreatePerson::Container
  extend Dry::Container::Mixin

  register 'steps.validate', -> { CreatePerson::Steps::Validate.new }
  register 'steps.create', -> { CreatePerson::Steps::Create.new }
end
