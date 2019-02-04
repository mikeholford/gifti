require 'rails_helper'

RSpec.describe Voucher, type: :model do

  describe ".save_screenshot" do
    context 'when screenshot is captured' do
      let(:voucher) { FactoryBot.create :voucher }
      it 'responds with URL' do
        puts "VOUCHER IMAGE: #{voucher.image_url}"
        expect(voucher.image_url).not_to be_nil
      end
    end
  end

end
