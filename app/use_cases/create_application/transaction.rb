# frozen_string_literal: true

class CreateApplication::Transaction
  include Dry::Transaction(container: CreateApplication::Container)

  step :validate, with: 'steps.validate'
  try :create, with: 'steps.create', catch: StandardError
end
