class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :validate_post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:categories, :comments, :user).order(comments_count: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.post_id = generate_unique_post_id

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post.post_id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.comments_count.zero?
      @post.destroy
      redirect_to posts_path
    else
      flash[:notice] = 'Deleting Post with existing comment is not allowed'
      redirect_to post_path(@post)
    end
  end

  private

  def validate_post_owner
    unless @post.user == current_user
      flash[:notice] = "the post doesn't belong to you"
      redirect_to posts_path
    end
  end
  
  def set_post
    @post = Post.find_by(post_id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :address, category_ids: [])
  end

  def generate_unique_post_id
    def new_post_id
      "#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
    end

    if Post.unscoped.all.size < 9999
      post_id = new_post_id
      post_id = new_post_id while !post_id.empty? && Post.where(post_id: post_id).size.positive?
    else
      flash[:notice] = 'Post limit reached, please contact administrator'
      redirect_to new_post_path
    end
    post_id
  end
end
