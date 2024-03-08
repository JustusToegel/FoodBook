class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :meals, dependent: :destroy
  has_many :carts, dependent: :destroy

  # to see Users meals in cart put user.meals_in_cart
  # has_many :meals_in_cart, through: :carts, source: :meals
  # has_many :meals, through: :carts, as: :meals_in_cart

  has_one_attached :photo

  validates :email, presence: true
  validates :email, uniqueness: true
  # validates :password, presence: true
  # validates :password, length: { minimum: 5 }
  validates :name, presence: true
  validates :bio, presence: true
  validates :description, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name],
    using: {
      tsearch: { prefix: true }
    }
end
