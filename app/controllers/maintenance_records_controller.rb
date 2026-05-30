class MaintenanceRecordsController < ApplicationController
  before_action :set_maintenance_record, only: [:show, :update, :destroy]
  before_action :verify_category_exists, only: [:create, :update]

  # GET /maintenance_records (ordered by name, includes category name, optional status filter)
  def index
    # We include the category association to avoid N+1 queries
    @records = MaintenanceRecord.includes(:category).order(:name)

    if params[:status].present?
      @records = @records.where(status: params[:status])
    end

    render json: @records.as_json(include: { category: { only: :name } })
  end

  # GET /maintenance_records/:id (includes category)
  def show
    render json: @maintenance_record.as_json(include: :category)
  end

  # POST /maintenance_records (verifies category exists)
  def create
    @maintenance_record = MaintenanceRecord.new(maintenance_record_params)

    if @maintenance_record.save
      render json: @maintenance_record, status: :created
    else
      render json: @maintenance_record.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /maintenance_records/:id
  def update
    if @maintenance_record.update(maintenance_record_params)
      render json: @maintenance_record
    else
      render json: @maintenance_record.errors, status: :unprocessable_entity
    end
  end

  # DELETE /maintenance_records/:id
  def destroy
    @maintenance_record.destroy
    head :no_content
  end

  private

  def set_maintenance_record
    @maintenance_record = MaintenanceRecord.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Maintenance record not found" }, status: :not_found
  end

  def verify_category_exists
    category_id = params.dig(:maintenance_record, :category_id)
    unless Category.exists?(category_id)
      render json: { error: "Category does not exist" }, status: :bad_request
    end
  end

  def maintenance_record_params
    params.require(:maintenance_record).permit(:name, :status, :performed_at, :category_id, :description)
  end
end