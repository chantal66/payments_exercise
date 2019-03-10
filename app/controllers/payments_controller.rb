class PaymentsController < ApplicationController
  before_action :set_loan, only: [:index, :create, :show]
  before_action :set_payment, only: [:show]

  def index
    render json: @loan.payments
  end

  def show
    render json: @payment
  end

  def create
    outstanding_balance = @loan.outstanding_balance
    @payment = @loan.payments.new(payment_params)
    if @payment.valid? && @payment.payment_amount < outstanding_balance
      @payment.save
      render json: @payment
    else
      render json: {
          error: "Your payment should not exceed the outstanding balance",
          full_errors: @payment.errors.full_messages
      },  status: 422
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_date, :payment_amount)
  end

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end

  def set_payment
   @payment = @loan.payments.find(params[:id])
  end
end