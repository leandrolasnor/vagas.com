# frozen_string_literal: true

class Calculator::Application
  extend Dry::Initializer

  param :application

  def score!
    application.update(score: calcule_score)
  end

  private

  def calcule_score
    @calcule_score ||= ((n + d) / 2).to_i
  end

  def n
    nv = application.job.nivel
    nc = application.person.nivel
    100 - (25 * (nv - nc).abs)
  end

  def d
    edges = Rails.cache.fetch(:edges)
    points = {
      source: application.job.localizacao,
      destination: application.person.localizacao
    }

    traced = Dijkstra.new(edges).(**points)
    traced.distance
  end
end
