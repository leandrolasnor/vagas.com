# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Http::CreateApplication::CalculateScore::Job do
  describe '#call' do
    context 'on Failure' do
      before do
        allow(Rails.logger).to receive(:error)
        described_class.new.perform(0)
      end

      it 'must be able to record a exception message on logger' do
        expect(Rails.logger).to have_received(:error)
      end
    end

    context 'on Success' do
      let(:application) { create(:application) }

      let(:edges) do
        [
          ['A', 'B', 5],
          ['B', 'C', 7],
          ['C', 'E', 4],
          ['E', 'D', 10],
          ['D', 'B', 3],
          ['D', 'F', 8]
        ]
      end

      before do
        allow(Rails.cache).to receive(:fetch).with(:edges).and_return(edges)
        allow(Rails.logger).to receive(:error)
        described_class.new.perform(application.id)
      end

      it 'must not be able to record a exception message on logger' do
        expect(Rails.logger).not_to have_received(:error)
      end
    end
  end
end
