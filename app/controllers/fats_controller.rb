class FatsController < ApplicationController
  before_action :set_fat, only: [:show, :edit, :update, :destroy]

  # GET /fats
  # GET /fats.json
  def index
    @fats = Fat.all
  end

  # GET /fats/1
  # GET /fats/1.json
  def show
  end

  # GET /fats/new
  def new
    @fat = Fat.new
  end

  # GET /fats/1/edit
  def edit
  end

  # POST /fats
  # POST /fats.json
  def create
    @fat = Fat.new(fat_params)

    respond_to do |format|
      if @fat.save
        format.html { redirect_to @fat, notice: 'Fat was successfully created.' }
        format.json { render :show, status: :created, location: @fat }
      else
        format.html { render :new }
        format.json { render json: @fat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fats/1
  # PATCH/PUT /fats/1.json
  def update
    respond_to do |format|
      if @fat.update(fat_params)
        format.html { redirect_to @fat, notice: 'Fat was successfully updated.' }
        format.json { render :show, status: :ok, location: @fat }
      else
        format.html { render :edit }
        format.json { render json: @fat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fats/1
  # DELETE /fats/1.json
  def destroy
    @fat.destroy
    respond_to do |format|
      format.html { redirect_to fats_url, notice: 'Fat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fat
      @fat = Fat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fat_params
      params.require(:fat).permit(:user_id, :value, :date)
    end
end
