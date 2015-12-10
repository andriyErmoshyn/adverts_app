class CommentsController < ApplicationController
  load_and_authorize_resource :ad
  load_and_authorize_resource :comment, :through => :ad

  def create
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @ad }
        format.js
      end
    end
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to @ad
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @ad }
      format.js
    end    
  end

  private
  
    def comment_params
      params.require(:comment).permit(:body)
    end

end
