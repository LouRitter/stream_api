class User < ApplicationRecord
  has_many :watchlists, dependent: :destroy
  has_many :videos, through: :watchlists
end