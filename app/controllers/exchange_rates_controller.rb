class ExchangeRatesController < ApplicationController
  before_action :set_exchange_rate, only: [:show, :edit, :update, :destroy]

  # GET /exchange_rates
  # GET /exchange_rates.json
  def index
    @exchange_rates = ExchangeRate.all
  end

  # GET /exchange_rates/1
  # GET /exchange_rates/1.json
  def show
  end

  # GET /exchange_rates/new
  def new
    @exchange_rate = ExchangeRate.new
  end

  # GET /exchange_rates/1/edit
  def edit
  end

  # POST /exchange_rates
  # POST /exchange_rates.json
  def create
    @exchange_rate = ExchangeRate.find_by(currency_one: exchange_rate_params[:currency_one], currency_two: exchange_rate_params[:currency_two], city: exchange_rate_params[:city])
    if @exchange_rate.nil?
      @exchange_rate = ExchangeRate.new(exchange_rate_params)
    else
      @exchange_rate.update(exchange_rate_params)
    end

    respond_to do |format|
      if @exchange_rate.save
        format.html { redirect_to exchange_rates_path, notice: 'Exchange rate was successfully created.' }
        format.json { render :show, status: :created, location: @exchange_rate }
      else
        format.html { render :new }
        format.json { render json: @exchange_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_exchange_rates].split(',').each do |id|
      ExchangeRate.find(id).destroy
      deleted = deleted + 1
    end
    redirect_to exchange_rates_path, notice: "You have deleted #{deleted} exchange rates."
  end

  # PATCH/PUT /exchange_rates/1
  # PATCH/PUT /exchange_rates/1.json
  def update
    respond_to do |format|
      if @exchange_rate.update(exchange_rate_params)
        format.html { redirect_to @exchange_rate, notice: 'Exchange rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @exchange_rate }
      else
        format.html { render :edit }
        format.json { render json: @exchange_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchange_rates/1
  # DELETE /exchange_rates/1.json
  def destroy
    @exchange_rate.destroy
    respond_to do |format|
      format.html { redirect_to exchange_rates_url, notice: 'Exchange rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange_rate
      @exchange_rate = ExchangeRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exchange_rate_params
      params.require(:exchange_rate).permit(:account_id, :currency_one, :currency_two, :buying, :selling, :city)
    end
end
