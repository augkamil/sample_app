class MicropostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(params[:micropost])
      flash[:success] = "Micropost updated!"
      redirect_to @micropost
    else
      flash[:error] = "Try again!"
      render "edit"
    end
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def destroy
    @micropost.destroy
    if current_user.admin?
      redirect_to user_path(@micropost.user)
    else
      redirect_to root_url
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  private

    def correct_user
      if current_user.admin?
        @micropost = Micropost.find(params[:id])
      else
        @micropost = current_user.microposts.find_by_id(params[:id]) 
      end
        redirect_to root_url if @micropost.nil?
    end
end