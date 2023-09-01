# frozen_string_literal: true

class Http::CreateJob::Serializer < ActiveModel::Serializer
  attributes :empresa, :titulo, :descricao, :localizacao, :nivel
end
