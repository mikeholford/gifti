class ApiAccess < ApplicationRecord
  belongs_to :user
  has_many :api_requests

  after_create :generate_key

  validates_presence_of :name, message: "must be present"
  validates_presence_of :website_url, message: "must be present"
  validates_presence_of :description, message: "must be present"

  def generate_key
    self.update(key: SecureRandom.hex(25))
  end
end
