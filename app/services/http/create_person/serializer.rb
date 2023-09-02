# frozen_string_literal: true

class Http::CreatePerson::Serializer < ActiveModel::Serializer
  attributes :name, :profissao, :localizacao, :nivel

  private

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
