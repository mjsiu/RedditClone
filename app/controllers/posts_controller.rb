class PostsController < ApplicationController

  before_action :redirect_to_login, except: :show

  def new
    @post = Post.new
    @cross_subs_id = Sub.all.map(&:id)
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
    @post = Post.find(params[:id])
    @cross_subs_id = @post.post_sub_sub_ids
  end

  def update
    @post = Post.find(params[:id])
    @cross_subs_id = @post.post_sub_sub_ids

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
    params.require(:post).permit(:sub_id, :author_id, :title, :url, :content, post_sub_sub_ids: [] )
  end
end
