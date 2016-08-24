class StatusesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @statuses = Status.all
    @comments = Comment.all
  end

  def show
    @status = Status.find(params[:id])
    @comments = @status.comments.all
  end

  def new
    @status = Status.new
    @comment = @status.comments.build
  end

  def create
    # @status = Status.new(status_params)
    # @status.user = current_user
    @status = current_user.statuses.new(status_params)

    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        format.json { render :show, status: :created, location: @status }
      else
        format.html { render :new }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @status = current_user.statuses.find(params[:id])
    if params[:status] && params[:status].has_key?(:user_id)
       params[:status].delete(:user_id)
    end
    respond_to do |format|
      if @status.update(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { render :show, status: :ok, location: @status }
      else
        format.html { render :edit }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to statuses_url, notice: 'Status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_status
      @status = Status.find(params[:id])
    end

    def status_params
      params.require(:status).permit(:user_id, :content)
    end
end
