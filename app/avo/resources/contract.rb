# frozen_string_literal: true

module Avo
  module Resources
    class Contract < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :client, as: :belongs_to
        field :monthyl_fee, as: :number
        field :start_date, as: :date
        field :end_date, as: :date
        field :service_type, as: :number
      end
    end
  end
end
