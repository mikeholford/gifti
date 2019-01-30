class VoucherMailer < ApplicationMailer

  def send_scheduled_voucher(voucher)
    @voucher = voucher
    mail(
      :to => @voucher.for_email,
      from: "#{@voucher.from} <noreply@gifti.club>",
      reply_to: "#{@voucher.from} <#{@voucher.user.email}>",
      :subject => "Gift Voucher 🎁")
  end

end
