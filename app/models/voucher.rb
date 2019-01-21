class Voucher < ApplicationRecord
  belongs_to :user
  belongs_to :design

  after_create :save_screenshot

  def save_screenshot
    voucher_url = Screenshot.new({url: "#{Rails.root}vouchers/#{self.id}/key=#{self.user.secret_key}",thumbnail_max_width: 700,viewport: "700x300"}).url
    self.update(image: voucher_url)
  end

end
