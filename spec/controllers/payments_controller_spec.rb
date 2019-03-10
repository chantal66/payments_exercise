require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 150.0) }
    let(:valid_params) { { payment_date: Date.today, payment_amount: 50.0 } }

    it 'responds with a 200' do
      post :create, params: { payment: valid_params, loan_id: loan.id, format: :json }
      expect(response).to have_http_status(:ok)
    end
  end
end