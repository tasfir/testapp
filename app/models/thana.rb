class Thana < Statusable
  belongs_to :district

  # Set up translations
  has_many :translations, as: :translatable, dependent: :destroy
  accepts_nested_attributes_for :translations

  validates :district_id, presence: true
end
