class Loan < ActiveRecord::Base
  has_many :payments
  validates :funded_amount, presence: true

  def outstanding_balance
    payments_sum = self.payments.sum(:payment_amount)
    self.funded_amount - payments_sum
  end
end
