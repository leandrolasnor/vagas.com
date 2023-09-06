# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CalculateScore::Model::Application, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to :job }
    it { is_expected.to belong_to :person }
  end

  describe 'Delegates' do
    it { is_expected.to delegate_method(:score!).to(:calculator) }
  end
end
