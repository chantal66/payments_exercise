class PaymentsController < ApplicationController
  before_action :set_loan, only: [:create]

  def create
    @payment = @loan.payments.create!(payment_params)
    render json: @payment
  end

  private

  def payment_params
    params.require(:payment).permit(:payment_date, :payment_amount)
  end

  def set_loan
    @loan = Loan.find(params[:loan_id])
  end
end