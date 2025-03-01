# frozen_string_literal: true

module Avo
  module Resources
    class Membership < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :user, as: :belongs_to
        field :memberable, as: :text
      end
    end
  end
end
