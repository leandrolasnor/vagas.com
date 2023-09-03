# frozen_string_literal: true

class CreatePerson::Transaction
  include Dry::Transaction(container: CreatePerson::Container)

  step :validate, with: 'steps.validate'
  try :create, with: 'steps.create', catch: StandardError
end
