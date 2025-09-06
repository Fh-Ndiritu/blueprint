class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile

  has_many :messages, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users
  after_create_commit :create_profile

  delegate :name, to: :profile

  def obfuscated_email
    email
    email[0..5] = "*" * 5
    email
  end

  private

  def create_profile
    Profile.create!(user: self)
  end
end
