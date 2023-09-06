# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Dijkstra do
  describe 'Calculo minimum distance between two vertices on graph' do
    context 'scopes [A, F]' do
      subject { graph.(a, f).distance }

      let(:a) { 'A' }
      let(:f) { 'F' }
      let(:graph) { described_class.new(edges) }
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

      it { is_expected.to eq(expected_distance) }
    end
  end
end
