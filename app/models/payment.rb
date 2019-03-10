class Payment < ActiveRecord::Base
  belongs_to :loan
  validates :payment_amount, :payment_date, presence: true
end
