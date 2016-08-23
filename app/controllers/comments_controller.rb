class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params_comment)
  end

  def index
    @statuses = Status.all
    @comments = Comment.all
    @comment = Comment.find_by(params[:id])
  end

  private

  def params_comment
    params.require(:comment).permit(:content)
  end
end
