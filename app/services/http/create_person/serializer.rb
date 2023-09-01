# frozen_string_literal: true

class Http::CreatePerson::Serializer < ActiveModel::Serializer
  attributes :name, :profissao, :localizacao, :nivel
end
