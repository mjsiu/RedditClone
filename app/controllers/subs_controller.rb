class SubsController < ApplicationController

  before_action :redirect_to_login, except: [:show]
  before_action :redirect_to_sub, only: [:edit, :update]

  def new
    @sub = Sub.new
  end

  def create
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def redirect_to_sub
    redirect_to sub_url(@sub) unless current_user.id == params[:id]
  end

end
