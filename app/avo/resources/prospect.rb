# frozen_string_literal: true

module Avo
  module Resources
    class Prospect < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :organization, as: :belongs_to
        field :vision, as: :textarea
        field :facebook, as: :text
        field :linkedin, as: :text
        field :instagram, as: :text
        field :youtube, as: :text
        field :founder, as: :text
        field :founding_year, as: :text
        field :history, as: :textarea
        field :created_by, as: :text
        field :updated_by, as: :text
      end
    end
  end
end
