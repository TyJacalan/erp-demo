# frozen_string_literal: true

class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def index?
    user
  end

  class Scope
    def initialize(user, post)
      @user = user
      @post = post
    end
  end
end
