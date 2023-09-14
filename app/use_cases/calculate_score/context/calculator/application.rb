# frozen_string_literal: true

class CalculateScore::Context::Calculator::Application
  include Dry.Types()
  extend Dry::Initializer

  param :application, type: Instance(CalculateScore::Model::Application), reader: :private
  option :job, type: Instance(CalculateScore::Model::Job), default: -> { application.job }, reader: :private
  option :person, type: Instance(CalculateScore::Model::Person), default: -> { application.person }, reader: :private

  option :distances, type: Hash.map(Integer, Range), default: -> { CalculateScore::Model::Application::DISTANCES }, reader: :private

  option :dijkstra, type: Instance(Dijkstra), default: -> { Rails.cache.fetch(:dijkstra) }, reader: :private
  option :trace, type: Instance(Tracing), default: -> { dijkstra.(job.location, person.location) }, reader: :private
  option :distance, type: Strict::Integer, default: -> { trace.distance }, reader: :private

  option :d, type: Strict::Integer.constrained(lteq: 100, gteq: 0), default: -> { distances.select { _2.include?(distance) }.keys[0] }, reader: :private

  option :nv, type: Strict::Integer, default: -> { job.level }, reader: :private
  option :nc, type: Strict::Integer, default: -> { person.level }, reader: :private

  option :n, type: Strict::Integer, default: -> { 100 - (25 * (nv - nc).abs) }, reader: :private

  def score!
    application.update(score: calcule_score)
    calcule_score
  end

  private

  def calcule_score
    @calcule_score ||= ((n + d) / 2).to_i
  end
end
