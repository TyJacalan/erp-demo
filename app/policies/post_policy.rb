# frozen_string_literal: true

class PostPolicy
  def index?
    user
  end
end
