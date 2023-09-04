# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CalculateScore::Monad do
  describe '#call' do
    let(:dijkstra) do
      Dijkstra.new(
        [
          ['A', 'B', 5],
          ['B', 'C', 7],
          ['C', 'E', 4],
          ['E', 'D', 10],
          ['D', 'B', 3],
          ['D', 'F', 8]
        ]
      )
    end

    before { allow(Rails.cache).to receive(:fetch).with(:dijkstra).and_return(dijkstra) }

    context 'when application exist' do
      let(:call) { described_class.new.(application.id) }
      let(:job) { create(:job, location: 'A', level: 4) }
      let(:person) { create(:person, location: 'F', level: 2) }
      let(:application) { create(:application, job: job, person: person, score: some_score) }
      let(:some_score) { 1000 }
      let(:expected_score) { 37 }

      it 'must be able to calculate score' do
        expect(call.value!.score).not_to eq(some_score)
        expect(call.value!.score).to eq(expected_score)
      end
    end

    context 'when application not found' do
      let(:call) { described_class.new.(0) }

      it 'must be able to get a Failure' do
        expect(call).to be_failure
        expect(call.exception).to be_instance_of(ActiveRecord::RecordNotFound)
      end
    end
  end
end
