class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User', optional: true

  validates :transaction_type, inclusion: { in: %w[deposit withdraw transfer pay refund] }
  validates :amount, numericality: { greater_than: 0 }

  attr_accessor :recipient_username
  after_create :apply_transaction

  private

  def apply_transaction
    case transaction_type
    when "deposit"
      user.update(balance: user.balance + amount)
    when "withdraw"
      if user.balance >= amount
        user.update(balance: user.balance - amount)
      else
        raise ActiveRecord::Rollback, "Insufficient funds"
      end
    when "transfer"
      if user.balance >= amount && recipient.present?
        user.update(balance: user.balance - amount)
        recipient.update(balance: recipient.balance + amount)
      else
        raise ActiveRecord::Rollback, "Invalid transfer"
      end
    end
  end
end
