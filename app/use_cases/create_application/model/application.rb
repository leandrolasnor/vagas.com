# frozen_string_literal: true

class CreateApplication::Model::Application < ApplicationRecord
  belongs_to :person, class_name: 'CreateApplication::Model::Person'
  belongs_to :job, class_name: 'CreateApplication::Model::Job'
end
