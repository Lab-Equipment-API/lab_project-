class Category < ApplicationRecord
  has_many :equipment
  validates :name,
            presence: true,
            uniqueness: true,
            length: { minimum: 3 }

end
