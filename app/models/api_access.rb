class ApiAccess < ApplicationRecord
  belongs_to :user
  has_many :api_requests

  after_create :generate_key
  after_create :notify_admin

  validates_presence_of :name, message: "must be present"
  validates_presence_of :website_url, message: "must be present"
  validates_presence_of :description, message: "must be present"

  def generate_key
    self.update(key: SecureRandom.hex(25))
  end

  def notify_admin
    NotifieeAPI.notify(:mike, :telegram, "New API Access:\nUser: #{self.user.email}\nName: #{self.name}\nWebsite: #{self.website_url}\nDescription: #{self.description}")
  end
end
