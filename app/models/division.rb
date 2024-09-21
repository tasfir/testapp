class Division < Statusable
  has_many :translations, as: :translatable, dependent: :destroy
  accepts_nested_attributes_for :translations
end
