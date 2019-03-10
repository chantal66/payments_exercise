require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'has the valid attributes' do
      loan.payments.create!({ payment_date: Date.today, payment_amount: 50.0 })

      get :index
      raw_loan = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_loan["id"]).to eq(loan.id)
      expect(raw_loan["funded_amount"].to_f).to eq(loan.funded_amount)
      expect(raw_loan["outstanding_balance"].to_f).to eq(loan.outstanding_balance)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, params: { id: loan.id }
      expect(response).to have_http_status(:ok)
    end

    it 'has the valid attributes' do
      loan.payments.create!({ payment_date: Date.today, payment_amount: 50.0 })

      get :index
      raw_loan = JSON.parse(response.body).first

      expect(response).to have_http_status(200)
      expect(raw_loan["id"]).to eq(loan.id)
      expect(raw_loan["funded_amount"].to_f).to eq(loan.funded_amount)
      expect(raw_loan["outstanding_balance"].to_f).to eq(loan.outstanding_balance)
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, params: { id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
