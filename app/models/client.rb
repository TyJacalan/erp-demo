# frozen_string_literal: true

class Client < ApplicationRecord
  has_one_attached :logo
  has_and_belongs_to_many :users
  has_many :contracts

  validates :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true
end