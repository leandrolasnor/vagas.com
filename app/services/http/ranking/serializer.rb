# frozen_string_literal: true

class Http::Ranking::Serializer < ActiveModel::Serializer
  attributes :nome, :profissao, :localizacao, :nivel, :score

  def nome
    object.person.name
  end

  def profissao
    object.person.profession
  end

  def localizacao
    object.person.location
  end

  def nivel
    object.person.level
  end

  def score
    object.score
  end
end
