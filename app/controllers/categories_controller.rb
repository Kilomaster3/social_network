# frozen_string_literal: true

class CategoriesController < AccountBaseAuthController
  before_action :find_category, only: %i[edit update destroy]

  def index
    @categories = Category.includes(:interests).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:success] = 'Categories were updated'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = 'Categories were deleted'
      redirect_to categories_path
    else
      flash[:success] = 'Categories were not deleted'
    end
  end

  private

    def find_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:id, :name)
    end
end
