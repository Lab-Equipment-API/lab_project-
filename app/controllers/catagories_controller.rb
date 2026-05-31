class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  # GET /categories
  def index
    @categories = Category.order(:name)
    render json: @categories.as_json(include_equipment_count: true)
  end

  # GET /categories/:id
  def show
    render json: @category.as_json(include_equipment_count: true)
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    
    if @category.save
      render json: @category.as_json(include_equipment_count: true), status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /categories/:id
  def update
    if @category.update(category_params)
      render json: @category.as_json(include_equipment_count: true), status: :ok
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  def destroy
    if @category.equipment.exists?
      count = @category.equipment.count
      render json: { error: "Cannot delete category. #{count} equipment items still belong to it." }, 
             status: :conflict
    else
      @category.destroy
      head :no_content
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Category not found" }, status: :not_found
  end

  def category_params
    params.require(:category).permit(:name)
  end
end