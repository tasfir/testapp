class District < ApplicationRecord
  include HasTranslations

  belongs_to :division
end
