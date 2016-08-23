class CommentsController < ApplicationController

    def create
      @status = Status.find(params[:status_id])
      @comment = @status.comments.create(comment_params)
      @comment.user_id = current_user.id if current_user
      @comment.save
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

end


