# frozen_string_literal: true

class CreateJob::Model::Job < ApplicationRecord
  enum :level, [:trainee, :junior, :full, :senior, :specialist]
end
