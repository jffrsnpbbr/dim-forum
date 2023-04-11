class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_user
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :validate_has_zero_post, only: [:destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def show
    @category
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path 
  end

  private

  def validate_user
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def validate_has_zero_post
    unless @category.posts.size.zero?
      flash[:notice] = 'cannot delete category that has post'
      redirect_to categories_path
    end
  end

  def set_category
    @category = Category.includes(:posts).find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
