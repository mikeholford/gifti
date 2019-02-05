require 'rails_helper'

RSpec.describe ApiRequest, type: :model do

  context 'request is made' do
    let(:api_request) { FactoryBot.create :api_request }
    it 'has a path' do
      expect(api_request.path).not_to be_nil
    end
  end

end
