require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when user is created' do

    before do
      @user = User.create(email: Faker::Internet.email)
    end

    it 'responds with email' do
      expect(@user.email).not_to be_nil
    end

  end
end
