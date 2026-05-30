class Equipment < ApplicationRecord
  belongs_to :category
  has_many :maintenance_records, dependent: :destroy 

  validates :name, presence: true

  validates :serial_number,
            presence: true,
            uniqueness: true,
            format: {
              with: /\A[A-Z]{3}-\d{3}\z/
            }

  validates :status,
            inclusion: {
              in: %w[
                available
                in_use
                maintenance
              ]
            }

 validate :name_must_be_real

private

def name_must_be_real
  return if name.blank?
  if name.length < 3
    errors.add(:name, "must be at least 3 characters")
  elsif !name.match?(/[a-zA-Z]/)
    errors.add(:name, "must contain at least one letter")
  end
end
end


