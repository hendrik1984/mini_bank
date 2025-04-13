class User < ApplicationRecord
    has_secure_password

    has_many :transactions, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :role, presence: true, inclusion: { in: %w[admin customer merchant] }
    validates :balance, numericality: { greater_than_or_equal_to: 0 }

    # For tranfers (recipient)
    has_many :received_transactions, class_name: 'Transaction', foreign_key: 'recipient_id'
end
