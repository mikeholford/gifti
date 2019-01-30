class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable, :async

  has_many :vouchers
  has_many :api_accesses

  after_create :create_secret_key
  after_create :notify_admin
  before_validation :assign_password, on: :create

  def create_secret_key
    self.update(secret_key: SecureRandom.hex)
  end

  def notify_admin
    NotifieeAPI.notify(:mike, :telegram, "New Customer: #{self.email}")
  end

  def assign_password
    if !self.password
      new_password = SecureRandom.hex
      self.password = new_password
      self.password_confirmation = new_password
    end
  end

  def has_api_access?
    ApiAccess.all.where(user_id: self.id).last.present? ? true : false
  end

  protected

  def password_required?
    confirmed? ? super : false
  end
end
