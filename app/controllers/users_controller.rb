class UsersController < ApplicationController
  before_action :set_user, except: [:index]
  before_action :set_post, except: [:index]
  before_action :set_comments, except: [:index]

  def index
    unless redirect_to user_path(current_user.id)
      flash[:notice] = "the comment doesn't belong to you"
      render :index
    end
  end

  def show; end

  def posts; end

  def comments; end

  private 

  def set_user
    @user = User.find(params[:id] || params[:user_id])
  end

  def set_post
    @posts = Post.includes(:user).where(user: @user)
  end

  def set_comments
    @comments = Comment.includes(:user, :post).where(user: @user)
  end
end
