# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Calculator::Application do
  describe '.score!' do
    let(:expected_score) { 37 }
    let(:context) { described_class.new(application) }

    let(:application) do
      take = create(:application)
      take.job.location = 'A'
      take.person.location = 'F'
      take.person.level = 2
      take.job.level = 4
      take
    end

    before do
      allow(Rails.cache).to receive(:fetch).with(:dijkstra).and_return(
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
      )
    end

    it { expect(context.score!).to eq(expected_score) }
  end
end
