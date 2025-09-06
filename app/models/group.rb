class Group < ApplicationRecord
  has_one_attached :logo

  validates_presence_of :title, :description, :logo


  has_many :messages, dependent: :destroy

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  default_scope { order(created_at: :desc)}

  def member(user)
    group_users.find_by(user_id: user.id)
  end


end
