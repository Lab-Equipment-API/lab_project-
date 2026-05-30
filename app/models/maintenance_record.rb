class MaintenanceRecord < ApplicationRecord
  belongs_to :equipment

  validates :description, presence: true
  validates :performed_at, presence: true
  validates :equipment_id, presence: true

  # Business Rule 2: performed_at cannot be in the future
  validate :performed_at_not_in_future

  private

  def performed_at_not_in_future
    return unless performed_at.present?
    if performed_at > Time.current
      errors.add(:performed_at, "cannot be in the future")
    end
  end
end