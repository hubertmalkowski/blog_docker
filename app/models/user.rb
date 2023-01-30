class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :articles, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    if user_type == 1
      return true
    end
    false
  end
end
