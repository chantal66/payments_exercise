class Loan < ActiveRecord::Base
  has_many :payments
  validates :funded_amount, presence: true

  def outstanding_balance
    payments_sum = self.payments.sum(:payment_amount)
    total_payments = payments_sum == nil ? 0 : payments_sum
    self.funded_amount - total_payments
  end
end
