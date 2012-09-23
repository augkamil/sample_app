class CommentsController < ApplicationController
	def create
		@micropost = Micropost.find(params[:micropost_id])
		@comments = @micropost.comments.build(params[:comment])
		@comments.commenter = current_user.name
		@comments.save
		redirect_to @micropost
	end

  	def new
    	@micropost = Micropost.new(params[:comment])
  	end
end
