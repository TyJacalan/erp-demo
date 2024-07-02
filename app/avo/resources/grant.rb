# frozen_string_literal: true

module Avo
  module Resources
    class Grant < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :description, as: :textarea
        field :purpose, as: :number
        field :amount, as: :number
        field :year, as: :text
        field :grant_type, as: :number
        field :duration, as: :number
        field :organization, as: :belongs_to
        field :recipient_organization, as: :belongs_to
        field :program, as: :belongs_to
      end
    end
  end
end
