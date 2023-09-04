# frozen_string_literal: true

class CreatePerson::Model::Person < ApplicationRecord
  include Enums::Level
end
