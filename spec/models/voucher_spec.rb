require 'rails_helper'

RSpec.describe Voucher, type: :model do

  describe ".save_screenshot" do

    context 'when screenshot is captured' do
      before do
        @user = User.create(email: Faker::Internet.email)
        @design = Design.create(name: Faker::String.random)
        @voucher = Voucher.create(
          user_id: @user.id,
          design_id: @design.id,
          value: Faker::Number.number(2),
          service: Faker::Company.name,
        )
        @voucher.save(validations: false)
      end

      it 'responds with URL' do
        expect(@voucher[:image]).not_to be_nil
      end
    end

  end
end
