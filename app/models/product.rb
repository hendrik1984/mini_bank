class Product < ApplicationRecord
  belongs_to :category

  serialize :images, Array

  validates :status, presence: true, inclusion: { in: ["active", "inactive"] }
  validates :sku, uniqueness: true, presence: true

end
