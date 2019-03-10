require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 150.0) }
    let(:valid_params) { { payment_date: Date.today, payment_amount: 50.0 } }

    it 'responds with a 200' do
      post :create, params: { payment: valid_params, loan_id: loan.id, format: :json }
      expect(response).to have_http_status(:ok)
    end

    it 'creates a new payment' do
      expect { post :create, params: { payment: valid_params, loan_id: loan.id, format: :json }
      }.to change { Payment.count }.by(1)
    end

    context 'payment exceeds outstanding balance' do
      let(:invalid_params) { { payment_date: Date.today, payment_amount: 200.0 } }

      it 'returns status code 422' do
        post :create, params: { payment: invalid_params, loan_id: loan.id, format: :json }

        expect(response).to have_http_status(422)
        expect(response.body).to eq("Your payment should not exceed the outstanding balance")
      end
    end
  end

  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    it 'has the valid attributes' do
      loan.payments.create!({ payment_date: Date.today, payment_amount: 50.0 })

      get :index, params: { loan_id: loan.id }
      raw_loan = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_loan["id"]).to eq(loan.id)
      expect(raw_loan["payment_amount"].to_f).to eq(loan.payments.first.payment_amount)
      expect(raw_loan["payment_date"].to_datetime).to eq(loan.payments.first.payment_date)
    end
  end
end