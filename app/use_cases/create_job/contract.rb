# frozen_string_literal: true

module Types
  include Dry.Types()

  LevelJob = Types::String.constructor do
    CreateJob::Model::Job.levels.key(_1)
  end
end

class CreateJob::Contract < ApplicationContract
  extend Dry::Initializer

  option :locations, default: -> { Rails.cache.fetch(:dijkstra).map.keys }

  params do
    required(:empresa).filled(:string)
    required(:titulo).filled(:string)
    required(:descricao).filled(:string)
    required(:localizacao).filled(:string)
    required(:nivel).type(Types::LevelJob).value(included_in?: CreateJob::Model::Job.levels.keys)
  end

  register_macro(:known_location) do
    known = locations.include?(values[:localizacao])
    key(:localizacao).failure(:unknown_location) unless known
  end

  rule(:localizacao).validate(:known_location)
end
