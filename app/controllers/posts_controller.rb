class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update show]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new

    return if session[:user_id]

    redirect_to posts_path
    flash[:alert] = 'You need to login to create a post'
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = @post.errors.full_messages.join(', ')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return if @post.user.id == session[:user_id]

    redirect_to post_path(@post.id)
    flash[:alert] = "You're not the author of this post"
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      flash.now[:notice] = @post.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end