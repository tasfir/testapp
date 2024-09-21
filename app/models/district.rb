class District < ApplicationRecord
  belongs_to :division

  has_many :translations, as: :translatable, dependent: :destroy
  accepts_nested_attributes_for :translations
end
