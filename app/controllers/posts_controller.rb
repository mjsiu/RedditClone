class PostsController < ApplicationController

  before_action :redirect_to_login, except: :show

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post = post.find(params[:id])
  end

  def update
    @post = post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @author = @post.author.username
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  private
  def post_params
    params.require(:post).permit(:sub_id, :author_id, :title, :url, :content)
  end
end
