class Loan < ActiveRecord::Base
  has_many :payments
  validates :funded_amount, presence: true

  def outstanding_balance
    self.funded_amount - self.payments_sum
  end

  def payments_sum
    payments_sum = self.payments.sum(:payment_amount)
    payments_sum == nil ? 0 : payments_sum
  end
end
