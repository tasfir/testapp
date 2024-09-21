class Thana < Statusable
  belongs_to :district

  # Set up translations
  has_many :translations, as: :translatable, dependent: :destroy

  validates :district_id, presence: true
end
