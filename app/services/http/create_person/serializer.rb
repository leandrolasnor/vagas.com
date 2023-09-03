# frozen_string_literal: true

class Http::CreatePerson::Serializer < ActiveModel::Serializer
  attributes :nome, :profissao, :localizacao, :nivel

  def nome
    object.name
  end

  def profissao
    object.profession
  end

  def localizacao
    object.location
  end

  def nivel
    object.level
  end
end
