# frozen_string_literal: true

module Avo
  module Resources
    class Program < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :name, as: :text
        field :description, as: :textarea
        field :issue_areas, as: :textarea
        field :target_funding, as: :number
        field :current_funding, as: :number
        field :organization, as: :belongs_to
      end
    end
  end
end
