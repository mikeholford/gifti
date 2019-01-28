require 'rails_helper'

describe API::V1::Templates do
  context 'when template endpoint is called' do

    before do
      @user = User.create(email: Faker::Internet.email)
      @access = ApiAccess.create(name: Faker::Company.name, website_url: Faker::String.random, description: Faker::String.random, key: SecureRandom.hex, user_id: @user.id)
    end

    it 'returns correct template' do
      template = (Faker::Company.name).downcase.parameterize
      @design = Design.create(template: template)
      get "/api/v1/templates/#{template}", params: {}, headers: { 'Authorization' => @access.key }
      expect(JSON.parse(response.body)['id']).to eq(@design.id)
    end

    it 'returns wrong template' do
      template = (Faker::Company.name).downcase.parameterize
      @design = Design.create(template: template)
      get "/api/v1/templates/random", params: {}, headers: { 'Authorization' => @access.key }
      expect(JSON.parse(response.body)['id']).to_not eq(@design.id)
    end

  end
end
