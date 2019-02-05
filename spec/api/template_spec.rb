require 'rails_helper'

describe API::V1::Templates do

  let(:api_access) { FactoryBot.create :api_access }

  describe '/templates' do
    context 'authenticated user gets templates' do

      before do
        @design = FactoryBot.create :design
      end

      it 'returns an array of templates' do
        get "/api/v1/templates", params: {}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)).to be_an_instance_of(Array)
      end
      it 'returns correct template hash' do
        get "/api/v1/templates", params: {}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body).last["id"]).to eq(@design.template)
      end
    end
    context 'unauthenticated user gets templates' do
      it 'returns an authentication error' do
        get "/api/v1/templates", params: {}, headers: { 'Authorization' => "" }
        expect(JSON.parse(response.body)["error"]).to eq("401 Unauthorized")
      end
    end
  end

  describe '/templates/:id' do
    context 'authenticated use gets a template' do
      let(:design) { FactoryBot.create :design }
      it 'returns correct template' do
        get "/api/v1/templates/#{design.template}", params: {}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)['id']).to eq(design.template)
      end
      it 'returns wrong template' do
        get "/api/v1/templates/random", params: {}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)['id']).to_not eq(design.template)
      end
    end
    context 'authenticated use gets a template' do
      it 'returns an authentication error' do
        get "/api/v1/templates", params: {}, headers: { 'Authorization' => "" }
        expect(JSON.parse(response.body)["error"]).to eq("401 Unauthorized")
      end
    end
  end

end
