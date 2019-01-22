class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable

  has_many :vouchers

  after_create :create_secret_key
  before_validation :assign_password, on: :create

  def create_secret_key
    self.update(secret_key: SecureRandom.hex)
  end

  def assign_password
    if !self.password
      new_password = SecureRandom.hex
      self.password = new_password
      self.password_confirmation = new_password
    end
  end

  protected

  def password_required?
    confirmed? ? super : false
  end
end
