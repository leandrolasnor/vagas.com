# frozen_string_literal: true

class Application < ApplicationRecord
  DISTANCES = { '100': (0..5), '75': (6..10), '50': (11..15), '25': (16..20), '0': (21..) }.freeze

  delegate :score!, to: :calculator

  belongs_to :job
  belongs_to :person

  private

  def calculator
    @calculator ||= Calculator::Application.new(self)
  end
end
