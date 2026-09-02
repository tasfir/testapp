module HasTranslations
  extend ActiveSupport::Concern

  included do
    has_many :translations, as: :translatable, dependent: :destroy
    accepts_nested_attributes_for :translations
  end

  def name(locale = "bn")
    translations.find { |t| t.locale == locale && t.key == "name" }&.value
  end
end
