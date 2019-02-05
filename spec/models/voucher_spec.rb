require 'rails_helper'

RSpec.describe Voucher, type: :model do

  describe ".create_ref" do
    context 'voucher is created' do
      let(:voucher) { FactoryBot.create :voucher }
      it 'has a reference' do
        expect(voucher.ref).not_to be_nil
      end
    end
  end

end
