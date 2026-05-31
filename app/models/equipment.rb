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
            def as_json(options = {})
            if options[:include_category]
              super(options).merge({ category_name: category&.name })
            else
              super(options)
            end
          end
        end
