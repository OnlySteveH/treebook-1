class CommentsController < ApplicationController

    def create
      @status = Status.find_by(params[:status_id])
      @comment = @status.comments.create(params_comment)
      @comment.save
      redirect_to statuses_path
    end

    def index
     @statuses = Status.all
     @comments = Comment.all
     @comment = Comment.find_by(params[:id])
    end


    def new
      @status  = Status.find(params[:status_id])
      @comment = Comment.new

    end
   private

   def params_comment
     params.require(:comment).permit(:content)
   end

end


