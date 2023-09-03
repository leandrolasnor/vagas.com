# frozen_string_literal: true

class CreateJob::Transaction
  include Dry::Transaction(container: CreateJob::Container)

  step :validate, with: 'steps.validate'
  try :create, with: 'steps.create', catch: StandardError
end
