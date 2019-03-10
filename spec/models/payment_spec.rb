require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe 'attributes' do
    it { is_expected.to respond_to :payment_date }
    it { is_expected.to respond_to :payment_amount }
  end

  describe 'relationships' do
    it { should belong_to :loan }
  end

  describe 'validations' do
    it { should validate_presence_of(:payment_amount) }
    it { should validate_presence_of(:payment_date) }
  end
end
