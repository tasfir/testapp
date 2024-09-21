class Statusable < ApplicationRecord
  self.abstract_class = true

  # Define constants for status values
  STATUS_PUBLISHED = "published".freeze
  STATUS_UNPUBLISHED = "unpublished".freeze

  # Define a method to return valid statuses
  def self.valid_statuses
    [ STATUS_PUBLISHED, STATUS_UNPUBLISHED ]
  end

  # Validation to ensure status is one of the valid statuses
  validates :status, inclusion: { in: valid_statuses }
end
