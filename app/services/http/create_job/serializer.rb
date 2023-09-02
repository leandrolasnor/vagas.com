# frozen_string_literal: true

class Http::CreateJob::Serializer < ActiveModel::Serializer
  attributes :empresa, :titulo, :descricao, :localizacao, :nivel

  def empresa
    object.company
  end

  def titulo
    object.title
  end

  def descricao
    object.description
  end

  def localizacao
    object.location
  end

  def nivel
    object.level
  end
end
