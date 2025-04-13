class Category < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :status, presence: true, inclusion: { in: ["active", "inactive"] }
end
