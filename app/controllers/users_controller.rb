require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.reverse_order!
  end

  # GET /users/1
  # GET /users/1.json
  def show #mypageにする
    #loginユーザでないとそのページを見れないようにする
    if session[:user_id] != params[:id].to_i
    end

    @weight_data = {}
    weight_data = Value.find_by_sql('select "date", "weight" from "values" where "user_id" = ' + params[:id])
    for data in weight_data do
      @weight_data[data[:date]] = data[:weight]
    end
    
    @fat_data = {}
    fat_data = Value.find_by_sql('select "date", "fat" from "values" where "user_id" = ' + params[:id])
    for data in fat_data do
      @fat_data[data[:date]] = data[:fat]
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user[:register_date] = Date.today

    #ここでパスワードの検証
    #Name or Emailがすでに登録されているものがあればエラー
    respond_to do |format|
      if user_params[:password] != user_params[:password_confirmation]
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }        
      elsif User.where(name: user_params[:name]).count != 0
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      elsif User.where(email: user_params[:email]).count != 0
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      elsif @user.save
        log_in @user
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      puts user_params
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email, :created_at)
    end
end
