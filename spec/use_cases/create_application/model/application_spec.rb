# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CreateApplication::Model::Application, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :job }
    it { is_expected.to belong_to :person }
  end
end
