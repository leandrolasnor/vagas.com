# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Dijkstra do
  describe 'Calculo minimum distance between two vertices on graph' do
    context 'scopes [A, F]' do
      let(:job) { create(:job, location: 'A') }
      let(:person) { create(:person, location: 'F') }
      let(:graph) { described_class.new(edges) }
      let(:trace) { graph.(job.location, person.location) }
      let(:expected_distance) { 16 }

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

      it 'must be able to calculate a distance between edges [A, F]' do
        expect(trace.distance).to eq(expected_distance)
      end
    end
  end
end
