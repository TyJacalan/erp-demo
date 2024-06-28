# frozen_string_literal: true

module Avo
  module Resources
  class Organization < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :website, as: :text
    field :mission, as: :textarea
    field :organization_type, as: :number
    field :location, as: :belongs_to
    field :logo, as: :text
  end
  end
  end
end
