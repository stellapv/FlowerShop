class CommentsController < ApplicationController
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to :back
    else
      redirect_to :back
      flash[:error] = "Comment couldn't be created"
    end
  end

  def index
    @comments = Flower.where(params[:flower_id]).first.comments
  end

  private
  
    def comment_params
      params.require(:comment).permit(:body, :user_id, :flower_id)
    end

end
