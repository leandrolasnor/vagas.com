# frozen_string_literal: true

class CalculateScore::Model::Application < ApplicationRecord
  delegate :score!, to: :calculator

  belongs_to :job, inverse_of: :application
  belongs_to :person, inverse_of: :application

  private

  def calculator
    @calculator ||= Calculator::Application.new(application: self)
  end
end
