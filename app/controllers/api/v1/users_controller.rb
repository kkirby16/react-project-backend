class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, except: :create
  before_action :set_user, only: [:show, :update, :destroy]

  #  GET /users
  def index
    @users = User.all

    render json: @users
  end

  #  GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id #session works when have frontend and backedn on rails app.
      render json: @user, status: :created
    else
      resp = {
        error: @user.errors.full_messages.to_sentence,
      }
      render json: resp, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  #Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:name, :username, :password)
  end #permitting these name, username and password attributes.
end
