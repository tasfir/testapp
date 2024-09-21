class Translation < ApplicationRecord
  belongs_to :translatable, polymorphic: true
end
