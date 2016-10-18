class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_is_admin, except: [:show, :edit, :update]
  helper_method :sort_column, :sort_direction

  def index
    @users = User.order(sort_column + ' ' + sort_direction)
  end

  def show
    sort_method_name = sort_requests_column
    @all_requests = @user.requests.sort_by { |request| request.public_send(sort_method_name) }
    @approved_requests = @user.requests.select(&:approved?)
    @pending_requests = @user.requests.select(&:pending?)
    @declined_requests  = @user.requests.select(&:declined?)
    if sort_direction == "desc"
      @all_requests = @all_requests.reverse!
    end
  end

  def new
    @user = User.new
    @teams = Team.all
  end

  def edit
    @teams = Team.all
  end

  def create
    @teams = Team.all
    @user = User.new(user_params)
    if user_params[:team_id]
      @user.team_name = (Team.find user_params[:team_id]).team_name
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @teams = Team.all
    respond_to do |format|
      unless user_params[:team_id].blank?
        @user.team_name = (Team.find user_params[:team_id]).team_name
      end
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
  def authenticate_is_admin
    current_user.admin?
  end 


  def sort_column
    params[:sort] || "last_name"
  end
  
  def sort_direction
    params[:direction] || "asc"
  end

  def sort_requests_column
    params[:sort] || "start_date"
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :role, :position, :team_name, :team_id)
  end
end
