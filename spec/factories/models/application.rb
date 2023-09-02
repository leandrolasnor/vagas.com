# frozen_string_literal: true

class Application < ApplicationRecord
  belongs_to :job
  belongs_to :person
end
