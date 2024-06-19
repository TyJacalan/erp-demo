# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def image_url(resource)
    resource.attached? ? url_for(resource) : nil
  end
end
