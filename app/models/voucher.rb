class Voucher < ApplicationRecord
  mount_uploader :image, GiftVoucherUploader
  belongs_to :user
  belongs_to :design

  after_create :create_ref
  after_create :save_screenshot unless Rails.env.development?

  validates_presence_of :value, message: "must be present"
  validates_presence_of :service, message: "must be present"
  validates_presence_of :for_email, message: "must be present", on: :update
  validates_presence_of :from, message: "must be present", on: :update
  validates_date :send_at, after: Date.today, after_message: "must be in the future", before: (Date.today + 2.months), before_message: "must be within 2 months", allow_blank: true, on: :update



  def create_ref
    self.update_attribute('ref', "#{SecureRandom.hex(1)}#{self.id}#{SecureRandom.hex(1)}")
  end

  def save_screenshot
    after_transaction do
      voucher_url = Screenshot.new({
        url: "https://gifti.club/vouchers/#{self.id}/capture/?key=#{self.user.secret_key}",
        thumbnail_max_width: self.design.width,
        viewport: "#{self.design.width}x#{self.design.height}"
      }).url
      self.update_attributes(remote_image_url: "#{voucher_url}")
    end
  end

end
