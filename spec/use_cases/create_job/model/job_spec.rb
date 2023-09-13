# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CreateJob::Model::Job, type: :model do
  describe 'Enums' do
    let(:enum_level) do
      [:trainee, :junior, :full, :senior, :specialist]
    end

    it do
      expect(subject).to define_enum_for(:level).with_values(enum_level)
    end
  end
end
