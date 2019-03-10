class LoansController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Loan.all, each_searialzer: LoanSerializer
  end

  def show
    render json: Loan.find(params[:id]), each_searialzer: LoanSerializer
  end
end
