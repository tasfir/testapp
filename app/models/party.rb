class Party < ApplicationRecord
  belongs_to :division
  belongs_to :district
  belongs_to :thana

  validates :name, :proprietor, :phone, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :status, inclusion: { in: ['published', 'draft', 'archived'] }
end
