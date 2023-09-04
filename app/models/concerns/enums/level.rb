# frozen_string_literal: true

module Enums::Level
  extend ActiveSupport::Concern

  included do
    enum :level, [:trainee, :junior, :full, :senior, :specialist]
  end
end
