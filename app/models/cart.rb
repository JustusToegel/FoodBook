class Cart < ApplicationRecord
  belongs_to :meal
  belongs_to :user
end
