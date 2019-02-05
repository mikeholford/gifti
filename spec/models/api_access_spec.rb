require 'rails_helper'

RSpec.describe ApiAccess, type: :model do

  context 'access is created' do
    let(:api_access) { FactoryBot.create :api_access }
    it 'generates a key' do
      expect(api_access.key).not_to be_nil
    end
  end

end
