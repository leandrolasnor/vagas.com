# frozen_string_literal: true

class V1::BaseController < ApplicationController
  def resolve(content, status, serializer = nil)
    render json: content, status: status, each_serializer: serializer
  end
end
