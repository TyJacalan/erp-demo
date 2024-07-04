# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id                :bigint           not null, primary key
#  mission           :text
#  name              :string
#  organization_type :integer          default("nonprofit"), not null
#  website           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  location_id       :bigint
#
# Indexes
#
#  index_organizations_on_location_id  (location_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class Organization < ApplicationRecord
  belongs_to :headquarter, class_name: 'Location', optional: true, foreign_key: :location_id
  has_many :grants, dependent: :destroy
  has_many :donations, class_name: 'Grant', foreign_key: :recipient_id, dependent: :destroy
  has_many :offices, dependent: :destroy
  has_many :programs, dependent: :destroy
  has_many :locations, through: :offices
  has_one_attached :logo
  has_one :client, dependent: :destroy
  has_one :prospect, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true

  accepts_nested_attributes_for :headquarter, reject_if: lambda { |attributes|
    attributes['city'].blank? && attributes['country'].blank?
  }
  accepts_nested_attributes_for :offices, allow_destroy: true, reject_if: lambda { |attributes|
    attributes['location_id'].blank? || attributes['location_id'] == '-1'
  }

  accepts_nested_attributes_for :grants, reject_if: :all_blank
  accepts_nested_attributes_for :programs, reject_if: :all_blank
  accepts_nested_attributes_for :prospect, reject_if: :all_blank

  after_save { Rails.cache.delete_matched(/^pagy-#{self.class.name}:/) }

  enum organization_type: { nonprofit: 0, for_profit: 1, government: 2, education: 3 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name organization_type]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[headquarter locations]
  end

  ransacker :city, formatter: proc { |v| v.mb_chars.downcase.to_s } do
    Arel.sql('LOWER(headquarter.city)')
  end

  ransacker :country, formatter: proc { |v| v.mb_chars.downcase.to_s } do
    Arel.sql('LOWER(headquarter.country)')
  end

  def full_headquarter
    return unless headquarter.present?

    if headquarter.state.present?
      "#{headquarter.city}, #{headquarter.state}, #{headquarter.country}"
    else
      "#{headquarter.city}, #{headquarter.country}"
    end
  end
end
