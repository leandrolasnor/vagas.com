# frozen_string_literal: true

class CreatePerson::Model::Person < ApplicationRecord
  enum :level, [:trainee, :junior, :full, :senior, :specialist]
end
