# frozen_string_literal: true

# == Schema Information
#
# Table name: prospects
#
#  id              :bigint           not null, primary key
#  facebook        :string
#  founder         :string
#  founding_year   :string
#  history         :text
#  instagram       :string
#  linkedin        :string
#  vision          :text
#  youtube         :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by_id   :bigint           not null
#  organization_id :bigint           not null
#  updated_by_id   :bigint           not null
#
# Indexes
#
#  index_prospects_on_created_by_id    (created_by_id)
#  index_prospects_on_organization_id  (organization_id)
#  index_prospects_on_updated_by_id    (updated_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (created_by_id => users.id)
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (updated_by_id => users.id)
#
class Prospect < ApplicationRecord
  belongs_to :organization
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'

  validates :linkedin,
            format: { with: %r{\Ahttps://www\.linkedin\.com/.*\z},
                      message: 'must be a valid LinkedIn URL' }, allow_blank: true
  validates :instagram,
            format: { with: %r{\Ahttps://www\.instagram\.com/.*\z},
                      message: 'must be a valid Instagram URL' }, allow_blank: true
  validates :youtube,
            format: { with: %r{\Ahttps://(www\.youtube\.com/|youtu\.be/).*?\z},
                      message: 'must be a valid YouTube URL' }, allow_blank: true
  validates :founding_year, format: { with: /\A\d{4}\z/,
                                      message: 'must be a valid year' }, allow_blank: true
end
