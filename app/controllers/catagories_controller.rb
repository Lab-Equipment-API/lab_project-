class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :update, :destroy]
  
    def index
      categories = Category.order(:name)
      render json: categories, status: :ok
    end
  
    def show
      render json: {
        id: @category.id,
        name: @category.name,
        equipment_count: @category.equipment.count
      }, status: :ok
    end
  
    def create
      category = Category.new(category_params)
  
      if category.save
        render json: category, status: :created
      else
        render json: { errors: category.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    def update
      if @category.update(category_params)
        render json: @category, status: :ok
      else
        render json: { errors: @category.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    def destroy
      count = @category.equipment.count
  
      if count > 0
        render json: {
          error: "Cannot delete category. #{count} equipment items still belong to it."
        }, status: :conflict
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