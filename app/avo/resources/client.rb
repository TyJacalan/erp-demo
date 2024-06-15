# frozen_string_literal: true

module Avo
  module Resources
    class Client < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :name, as: :text
        field :abbreviation, as: :text
        field :mission, as: :textarea
      end
    end
  end
end
