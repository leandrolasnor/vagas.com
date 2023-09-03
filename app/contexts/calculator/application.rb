# frozen_string_literal: true

class Calculator::Application
  extend Dry::Initializer

  param :application

  option :distances, default: -> { CalculateScore::Model::Application::DISTANCES }

  option :job, default: -> { application.job }
  option :person, default: -> { application.person }

  option :edges, default: -> { Rails.cache.fetch(:edges) }
  option :graph, default: -> { Dijkstra.new(edges) }
  option :trace, default: -> { graph.(job.location, person.location) }

  option :d, default: -> { distances.select { _2.include?(trace.distance) }.keys[0].to_s.to_i }

  option :nv, default: -> { job.level }
  option :nc, default: -> { person.level }

  option :n, default: -> { 100 - (25 * (nv - nc).abs) }

  def score!
    application.update(score: calcule_score)
    calcule_score
  end

  private

  def calcule_score
    @calcule_score ||= ((n + d) / 2).to_i
  end
end
