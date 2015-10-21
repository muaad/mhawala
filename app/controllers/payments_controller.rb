class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy, :send_through_mpesa, :withdraw]
  before_filter :authenticate_user!

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
    if !params[:user_type].blank?
      user = User.find(params[:user])
      if params[:user_type] == "sender"
        @payments = Payment.where sender: user
      elsif params[:user_type] == "recipient"
        @payments = Payment.where recipient: user
      end
    elsif !params[:sent].blank?
        if params[:sent] == "1"
          @payments = Payment.where sent: true
        elsif params[:sent] == "0"
            @payments = Payment.where.not sent: true
        end
    end
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
    if !params[:user_type].blank?
      user = User.find(params[:user])
      if params[:user_type] == "sender"
        @payment.sender = user
      elsif params[:user_type] == "recipient"
        @payment.recipient = user
      end
    end
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    sender = User.find_by(phone_number: params[:sender_phone_number])
    recipient = User.find_by(phone_number: params[:recipient_phone_number])

    if sender.nil?
      sender = User.new phone_number: params[:sender_phone_number], name: params[:sender_name], email: params[:sender_email], user_type: "Customer"
      sender.password = "12345678"
      sender.save!
    end

    if recipient.nil?
      recipient = User.new phone_number: params[:recipient_phone_number], name: params[:recipient_name], email: params[:recipient_email], user_type: "Customer"
      recipient.password = "12345678"
      recipient.save!
    end

    @payment = Payment.new(payment_params)
    @payment.sender = sender
    @payment.recipient = recipient

    if params[:send_by_mpesa] == "on"
      @payment.channel = "Mpesa"
    else
      @payment.sent = true
    end

    @payment.recorded_by_id = current_user.id

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_multiple
    deleted = 0
    params[:delete_payments].split(',').each do |id|
      Payment.find_by(id: id).destroy
      deleted = deleted + 1
    end
    redirect_to payments_path, notice: "You have deleted #{deleted} payments."
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    sender = User.find_by(phone_number: params[:sender_phone_number])
    recipient = User.find_by(phone_number: params[:recipient_phone_number])

    if sender.nil?
      sender = User.new phone_number: params[:sender_phone_number], name: params[:sender_name], email: params[:sender_email], user_type: "Customer"
      sender.password = "12345678"
      sender.save!
    end

    if recipient.nil?
      recipient = User.new phone_number: params[:recipient_phone_number], name: params[:recipient_name], email: params[:recipient_email], user_type: "Customer"
      recipient.password = "12345678"
      recipient.save!
    end
    respond_to do |format|
      if @payment.update(payment_params)
        @payment.sender = sender
        @payment.recipient = recipient
        @payment.save!
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_through_mpesa
    @payment.update(channel: "Mpesa", sent: false)
    redirect_to @payment, notice: "#{@payment.amount} has been sent through Mpesa to #{@payment.recipient.phone_number}."
  end

  def withdraw
    @payment.update(withdrawn: !@payment.withdrawn, withdrawn_by_id: current_user.id)
    @payment.update(withdrawn_at: Time.now) if @payment.withdrawn
    redirect_to @payment, notice: @payment.withdrawn ? "#{@payment.amount} has successfully been withdrawn." : "withdrawal has been cancelled!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:sender_id, :recipient_id, :amount, :reference_number, :transaction_number, :account_id, :sent, :channel, :withdrawn, :recorded_by_id, :withdrawn_by_id, :withdrawn_at, :sent_from, :sent_to)
    end
end
