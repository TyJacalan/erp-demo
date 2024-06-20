# frozen_string_literal: true

module Avo
  module Resources
    class Task < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :department, as: :number
        field :category, as: :textarea
        field :hours, as: :number
        field :internal_deadline, as: :date_time
        field :client_deadline, as: :date_time
        field :user, as: :belongs_to
        field :client, as: :belongs_to
      end
    end
  end
end
