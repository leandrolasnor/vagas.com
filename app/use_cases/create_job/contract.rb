# frozen_string_literal: true

module Types
  include Dry.Types()

  LevelJob = Types::String.constructor do
    CreateJob::Model::Job.levels.key(_1)
  end
end

class CreateJob::Contract < ApplicationContract
  params do
    required(:empresa).filled(:string)
    required(:titulo).filled(:string)
    required(:descricao).filled(:string)
    required(:localizacao).filled(:string)
    required(:localizacao).value(included_in?: Rails.cache.fetch(:dijkstra).map.keys)
    required(:nivel).type(Types::LevelJob).value(included_in?: CreateJob::Model::Job.levels.keys)
  end
end
