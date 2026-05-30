class MaintenanceRecord < ApplicationRecord
  belongs_to :equipment

  validates :description,
            presence: true

  validates :performed_at,
            presence: true

  validate :cannot_be_future

  private

  def cannot_be_future
    return if performed_at.blank?

    if performed_at > Time.current
      errors.add(
        :performed_at,
        "cannot be in the future"
      )
    end
  end
end
