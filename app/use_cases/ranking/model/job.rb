# frozen_string_literal: true

class Ranking::Model::Job < ApplicationRecord
  has_many :applications
end
