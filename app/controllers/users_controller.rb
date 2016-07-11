require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all.reverse_order!
    render 'index'
  end

  # GET /users/1
  # GET /users/1.json
  def show

    @username = ""
    users = User.where(id: params[:id])
    for user in users
      @username = user[:name]
    end

    @weight_data = {}
    weight_data = Value.find_by_sql('select "date", "weight" from "values" where "user_id" = ' + params[:id])
    for data in weight_data do
      @weight_data[data[:date]] = data[:weight]
    end

    #今月の平均
    tm = 0
    sum = 0
    for data in weight_data do
      if data[:date].month == Date.today.month and data[:weight]
        sum += data[:weight]
        tm += 1
      end
    end
    if tm != 0
      @this_month_weight = sum / tm
    else
      @this_month_weight = 0
    end

    #先月の平均
    tm = 0
    sum = 0
    for data in weight_data do
      if data[:date].month == Date.today.month-1 and data[:weight]
        sum += data[:weight]
        tm += 1
      end
    end
    if tm != 0
      @last_month_weight = sum / tm
    else
      @last_month_weight = 0
    end


    
    @fat_data = {}
    fat_data = Value.find_by_sql('select "date", "fat" from "values" where "user_id" = ' + params[:id])
    for data in fat_data do
      @fat_data[data[:date]] = data[:fat]
    end

    #今月の平均
    tm = 0
    sum = 0
    for data in fat_data do
      if data[:date].month == Date.today.month and data[:fat]
        sum += data[:fat]
        tm += 1
      end
    end
    if tm != 0
      @this_month_fat = sum / tm
    else
      @this_month_fat = 0
    end

    #先月の平均
    tm = 0
    sum = 0
    for data in fat_data do
      if data[:date].month == Date.today.month-1 and data[:fat]
        sum += data[:fat]
        tm += 1
      end
    end
    if tm != 0
      @last_month_fat = sum / tm
    else
      @last_month_fat = 0
    end

    render 'show'
  end

  def search
    user = User.where(name: params[:name])

    if user.count == 0
      flash.now[:danger] = "その名前のユーザは存在しません．"
      self.index
    end

    for u in user
      puts u.id
      params[:id] = u.id.to_s
      self.show
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
    if user_params[:password] != user_params[:password_confirmation]
      flash.now[:danger] = 'パスワードがwww一致していませんwwwww'
      render 'new'
    elsif User.where(name: user_params[:name]).count != 0
      flash.now[:danger] = 'その名前はすでに使われていマウス'
      render 'new'
    elsif User.where(email: user_params[:email]).count != 0
      flash.now[:danger] = 'そのメールアドレスはすでに使われていマウス'
      render 'new'
    elsif @user.save
      log_in @user
      redirect_to @user, notice: 'User was successfully created.'
    else
      flash.now[:danger] = 'なぞのエラー'
      render 'new'
    end
  end



  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      puts params
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
      params.require(:user).permit(:name, :password, :password_confirmation, :email, :created_at, :new_password, :new_password_confirmation)
    end
end
