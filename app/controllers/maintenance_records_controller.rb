class MaintenanceRecordsController < ApplicationController
  before_action :set_maintenance_record, only: [:show, :update, :destroy]

  # GET /maintenance_records
  # GET /maintenance_records?equipment_id=3
  def index
    records = MaintenanceRecord.includes(:equipment).order(performed_at: :desc)

    if params[:equipment_id].present?
      records = records.where(equipment_id: params[:equipment_id])
    end

    render json: records.map { |r| maintenance_record_json(r) }
  end

  # GET /maintenance_records/:id
  def show
    render json: maintenance_record_json(@maintenance_record)
  end

  # POST /maintenance_records
  def create
    # Verify equipment exists before creating
    equipment = Equipment.find_by(id: maintenance_record_params[:equipment_id])
    unless equipment
      return render json: { error: "Equipment not found" }, status: :unprocessable_entity
    end

    record = MaintenanceRecord.new(maintenance_record_params)

    if record.save
      render json: maintenance_record_json(record.reload), status: :created
    else
      render json: { errors: record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /maintenance_records/:id
  def update
    # If equipment_id is being changed, verify the new equipment exists
    if maintenance_record_params[:equipment_id].present?
      equipment = Equipment.find_by(id: maintenance_record_params[:equipment_id])
      unless equipment
        return render json: { error: "Equipment not found" }, status: :unprocessable_entity
      end
    end

    if @maintenance_record.update(maintenance_record_params)
      render json: maintenance_record_json(@maintenance_record.reload)
    else
      render json: { errors: @maintenance_record.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /maintenance_records/:id
  def destroy
    @maintenance_record.destroy
    head :no_content
  end

  private

  def set_maintenance_record
    @maintenance_record = MaintenanceRecord.includes(:equipment).find_by(id: params[:id])
    unless @maintenance_record
      render json: { error: "Maintenance record not found" }, status: :not_found
    end
  end

  def maintenance_record_params
    params.require(:maintenance_record).permit(:description, :performed_at, :equipment_id)
  end

  def maintenance_record_json(record)
    {
      id: record.id,
      description: record.description,
      performed_at: record.performed_at,
      equipment_id: record.equipment_id,
      equipment_name: record.equipment&.name,
      created_at: record.created_at,
      updated_at: record.updated_at
    }
  end
end