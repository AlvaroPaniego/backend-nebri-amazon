class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: %w[customer admin] }

  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
end
