class EquipmentController < ApplicationController
  before_action :set_equipment, only: [:show, :update, :destroy]

  # GET /equipment or /equipment?status=maintenance
  def index
    @equipment = Equipment.all
    
    if params[:status].present?
      @equipment = @equipment.where(status: params[:status])
    end

    render json: @equipment
  end

  # GET /equipment/:id
  def show
    render json: @equipment
  end

  # POST /equipment
  def create
    @equipment = Equipment.new(equipment_params)

    if @equipment.save
      render json: @equipment, status: :created
    else
      render json: @equipment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /equipment/:id
  def update
    if @equipment.update(equipment_params)
      render json: @equipment
    else
      render json: @equipment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /equipment/:id
  def destroy
    @equipment.destroy
    head :no_content
  end

  private

  def set_equipment
    @equipment = Equipment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Equipment not found" }, status: :not_found
  end

  def equipment_params
    # Allows tracking name and status based on standard equipment fields
    params.require(:equipment).permit(:name, :status)
  end
end