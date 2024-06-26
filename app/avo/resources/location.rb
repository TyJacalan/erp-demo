class Avo::Resources::Location < Avo::BaseResource
  self.includes = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :street, as: :text
    field :city, as: :text
    field :state, as: :text
    field :country, as: :country
    field :latitude, as: :text
    field :longitude, as: :text
  end
end
