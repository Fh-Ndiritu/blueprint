class Group < ApplicationRecord
  has_one_attached :logo
  has_many :messages, dependent: :destroy
  has_many :group_members, dependent: :destroy
  has_many :users, through: :group_members
end
