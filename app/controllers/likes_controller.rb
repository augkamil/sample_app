class LikesController < ApplicationController
  before_filter :signed_in_user

  def new
  	@micropost = Micropost.find(params[:micropost_id])
  	if !current_user?(@micropost.user)  		
  		@micropost.user_like_it(current_user)
  	end
    redirect_to micropost_path(@micropost)
  end

end
