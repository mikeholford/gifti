class Voucher < ApplicationRecord
  mount_uploader :image, GiftVoucherUploader
  belongs_to :user
  belongs_to :design

  after_create :create_ref
  after_create :save_screenshot unless Rails.env.development?

  validates_presence_of :heading, message: "must be present"
  validates_presence_of :for_email, message: "must be present", on: :update
  validates_presence_of :from, message: "must be present", on: :update
  validates_date :send_at, after: Date.today, after_message: "must be in the future", before: (Date.today + 2.months), before_message: "must be within 2 months", allow_blank: true, on: :update

  scope :scheduled, -> { where(scheduled: true) }

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
      self.update_attribute('remote_image_url', "#{voucher_url}")
    end
  end

  BLANK = {heading: "", sub_heading: "", for: "", valid_until: "", value: "", discount_type: "", code: "", service: ""}

  FAKE = [
    {
      heading: "LET'S GET DIVING!",
      sub_heading: "20% OFF everything in store just for you.",
      for: "👉 Jane Doe",
      valid_until: "#{(Date.today + 6.months).strftime("%d/%m/%y")}",
      value: "50",
      discount_type: "£",
      code: "🎁 UXMJWQ",
      service: "Mikes Dive Shop",
    },
  ]

end
