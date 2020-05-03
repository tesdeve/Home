class Contactinfo < ApplicationRecord
  belongs_to :contactable, polymorphic: true
end
