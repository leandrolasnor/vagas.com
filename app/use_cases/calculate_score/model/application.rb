# frozen_string_literal: true

class CalculateScore::Model::Application < ApplicationRecord
  enum distance: { '100': (0..5), '75': (6..10), '50': (11..15), '25': (16..20), '0': (21..) }

  delegate :score!, to: :calculator

  belongs_to :job, inverse_of: :application
  belongs_to :person, inverse_of: :application

  private

  def calculator
    @calculator ||= Calculator::Application.new(self)
  end
end
