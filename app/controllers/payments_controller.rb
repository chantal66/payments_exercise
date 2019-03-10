class PaymentsController < ApplicationController
  before_action :set_loan, only: [:index, :create, :show]

  def index
    render json: @loan.payments
  end

  def show
    render json: @loan.payments.find(params[:id])
  end

  def create
    outstanding_balance = @loan.outstanding_balance
    if payment_params[:payment_amount].to_f > outstanding_balance
      render json: "Your payment should not exceed the outstanding balance", status: 422
    else
      @payment = @loan.payments.create!(payment_params)
      render json: @payment
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_date, :payment_amount)
  end

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end