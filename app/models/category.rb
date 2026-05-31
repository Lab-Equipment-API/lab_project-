class Category < ApplicationRecord
  has_many :equipment, dependent: :restrict_with_error

  validates :name,
            presence: true,
            uniqueness: true,
            length: { minimum: 3 }
            def as_json(options = {})
            if options[:include_equipment_count]
              super(options).merge({ equipment_count: equipment.count })
            else
              super(options)
            end
          end
        end