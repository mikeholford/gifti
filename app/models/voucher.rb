class Voucher < ApplicationRecord
  belongs_to :user
  belongs_to :design

  after_create :save_screenshot

  def save_screenshot
    voucher_url = Screenshot.new({url: "https://gifti.club/vouchers/#{self.id}/?key=#{self.user.secret_key}",thumbnail_max_width: self.design.width,viewport: "#{self.design.width}x#{self.design.height}"}).url
    self.update(image: voucher_url)
  end

end
