class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :validate_comment_owner, only: [:edit, :update, :destroy]

  def index
    @comments = @post.comments
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if  @comment.save
      redirect_to post_comments_path(@post)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_comments_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_comments_path(@post)
  end

  private

  def validate_comment_owner
    unless @comment.user = current_user
      flash[:notice] = "the comment doesn't belong to you"
      redirect_to posts_comments_path(@post)
    end
  end

  def set_post
    @post = Post.find params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

end
