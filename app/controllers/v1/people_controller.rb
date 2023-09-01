# frozen_string_literal: true

class V1::PeopleController < V1::BaseController
  def create
    resolve(**Http::CreatePerson::Service.(params))
  end
end
