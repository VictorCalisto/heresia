class HeresiasController < ApplicationController
  before_action :set_heresia, only: %i[ show edit update destroy ]

  # GET /heresias or /heresias.json
  def index
    @heresias = Heresia.all
  end

  # GET /heresias/1 or /heresias/1.json
  def show
  end

  # GET /heresias/new
  def new
    @heresia = Heresia.new
  end

  # GET /heresias/1/edit
  def edit
  end

  # POST /heresias or /heresias.json
  def create
    @heresia = Heresia.new(heresia_params)

    respond_to do |format|
      if @heresia.save
        format.html { redirect_to heresia_url(@heresia), notice: "Heresia was successfully created." }
        format.json { render :show, status: :created, location: @heresia }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heresia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heresias/1 or /heresias/1.json
  def update
    respond_to do |format|
      if @heresia.update(heresia_params)
        format.html { redirect_to heresia_url(@heresia), notice: "Heresia was successfully updated." }
        format.json { render :show, status: :ok, location: @heresia }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heresia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heresias/1 or /heresias/1.json
  def destroy
    @heresia.destroy!

    respond_to do |format|
      format.html { redirect_to heresias_url, notice: "Heresia was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heresia
      @heresia = Heresia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def heresia_params
      params.require(:heresia).permit(:nome, :descricao)
    end
end
