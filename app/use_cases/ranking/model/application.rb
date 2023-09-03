# frozen_string_literal: true

class Ranking::Model::Application < ApplicationRecord
  belongs_to :person, class_name: 'Ranking::Model::Person'
end
