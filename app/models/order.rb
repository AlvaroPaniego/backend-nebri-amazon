class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  has_one :shipping_address, dependent: :destroy
  has_one :payment, dependent: :destroy

  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
