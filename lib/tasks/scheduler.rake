desc "Send scheduled vouchers"
task :send_scheduled_vouchers => :environment do
  vouchers = Voucher.scheduled.where('send_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  vouchers.each do |voucher|
    VoucherMailer.send_scheduled_voucher(voucher).deliver_later
  end
end
