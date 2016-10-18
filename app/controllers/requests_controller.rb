class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find params[:user_id]
    @requests = @user.requests
  end

  def show
    @user = User.find params[:user_id]
  end

  def new
    @request = Request.new
    @user = User.find params[:user_id]
  end

  def edit
    @user = User.find params[:user_id]
  end

  def create
    @request = Request.new(request_attrs(request_params))
    @user = User.find params[:user_id]
    @request.user = @user
    respond_to do |format|
      if @request.save
        format.html { redirect_to user_request_path(@user, @request), notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end 
  end

  def update
    @user = User.find params[:user_id]
    respond_to do |format|
      if @request.update(request_attrs(request_params))
        format.html { redirect_to user_request_path(@user, @request), notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request.destroy
    @user = User.find params[:user_id]
    respond_to do |format|
      format.html { redirect_to user_requests_url(@user), notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def managed_requests
    @managed_users = current_user.managed_users.flatten
  end

  private
    
    def request_attrs(request_params)
      request_attrs = request_params.clone
      if !request_attrs["start_date"].blank?
        request_attrs["start_date"] = Date.strptime(request_attrs["start_date"], "%m/%d/%Y")
      end

      if !request_attrs["end_date"].blank?
        request_attrs["end_date"] = Date.strptime(request_attrs["end_date"], "%m/%d/%Y")
      end
      return request_attrs
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:start_date, :end_date, :status, :note, :user_id)
    end
end
