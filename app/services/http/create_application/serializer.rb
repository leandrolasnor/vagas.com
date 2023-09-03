# frozen_string_literal: true

class Http::CreateApplication::Serializer < ActiveModel::Serializer
  attributes :nome, :descricao

  def nome
    object.person.name
  end

  def descricao
    object.job.description
  end
end
