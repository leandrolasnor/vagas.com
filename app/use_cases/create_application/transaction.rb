# frozen_string_literal: true

class CreateApplication::Transaction
  include Dry::Transaction(container: CreateApplication::Container)

  tee :params
  try :validate, with: 'steps.validate', catch: StandardError
  try :create, with: 'steps.create', catch: StandardError

  private

  def params(i) end
end
