class Thana < Statusable
  include HasTranslations

  belongs_to :district

  validates :district_id, presence: true
end
