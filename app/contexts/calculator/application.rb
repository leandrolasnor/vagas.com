# frozen_string_literal: true

class Calculator::Application
  extend Dry::Initializer

  param :application

  option :job, default: -> { application.job }
  option :person, default: -> { application.person }

  option :edges, default: -> { Rails.cache.fetch(:edges) }
  option :graph, default: -> { Dijkstra.new(edges) }
  option :trace, default: -> { graph.(job.localizacao, person.localizacao) }

  option :d, default: -> { application.distances.find { _2.include?(trace.distance) }.first.to_i }

  option :nv, default: -> { job.nivel }
  option :nc, default: -> { person.nivel }

  option :n, default: -> { 100 - (25 * (nv - nc).abs) }

  def score!
    application.update(score: calcule_score)
  end

  private

  def calcule_score
    @calcule_score ||= ((n + d) / 2).to_i
  end
end
