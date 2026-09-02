class Group < ApplicationRecord
  validates :name, presence: true
  validates :status, inclusion: { in: %w[published unpublished] }
end
