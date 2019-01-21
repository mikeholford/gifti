class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :vouchers
  after_create :create_secret_key

  def create_secret_key
    self.update(secret_key: SecureRandom.hex)
  end
end
