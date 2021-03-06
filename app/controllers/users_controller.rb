class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
    if signed_in?
      flash[:error] = "You're loged in!"
    	redirect_to root_path
    else
      @user = User.new
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    if signed_in?
      flash[:error] = "You're loged in!"
      redirect_to root_path
    else
    	@user = User.new(params[:user])
    	if @user.save
        sign_in @user
  		  flash[:success] = "Welcome to the Sample App!"
     		redirect_to @user
  	 else
  	 	 render 'new'
  	 end
    end
  end

  def destroy
    if current_user.admin?
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_url 
    else
      flash[:success] = "You're an admin, don't delete yourself"
    end
  end

  def show
  	@user = User.find_by_id(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) 
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
