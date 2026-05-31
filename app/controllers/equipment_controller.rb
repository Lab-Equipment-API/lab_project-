class EquipmentController < ApplicationController
    before_action :set_equipment, only: [:show, :update, :destroy]
  
    # GET /equipment
    # GET /equipment?status=available
    def index
        @equipment = Equipment.includes(:category).order(:name)
        
        if params[:status].present?
          @equipment = @equipment.where(status: params[:status])
        end
        
        # ADD THIS LINE to render the JSON response
        render json: @equipment.map { |eq| eq.as_json.merge(category_name: eq.category&.name) }
      end
      # Manually add category_name to each equipment
      render json: @equipment.as_json.map { |eq|
        eq.merge('category_name' => eq['category_id'] ? Category.find(eq['category_id']).name : nil)
      }
    end
  
    # GET /equipment/:id
    def show
      render json: @equipment.as_json.merge({
        category_name: @equipment.category&.name,
        maintenance_records: @equipment.maintenance_records.order(performed_at: :desc)
      })
    end
  
    # POST /equipment
    def create
      @equipment = Equipment.new(equipment_params)
      
      if @equipment.save
        render json: @equipment.as_json.merge(category_name: @equipment.category&.name), status: :created
      else
        render json: { errors: @equipment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH /equipment/:id
    def update
      if @equipment.update(equipment_params)
        render json: @equipment.as_json.merge(category_name: @equipment.category&.name), status: :ok
      else
        render json: { errors: @equipment.errors.full_messages }, status: :unprocessable_entity
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
      params.require(:equipment).permit(:name, :serial_number, :status, :category_id)
    end
  end