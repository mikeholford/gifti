require 'rails_helper'

describe API::V1::Templates do

  let(:api_access) { FactoryBot.create :api_access }

  describe '/templates' do
    context 'when fetching all templates' do
      it 'returns an array of templates' do
        get "/api/v1/templates", params: {}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)['data']).to be_an_instance_of(Array)
      end
    end
  end

  describe '/templates/:id' do
    context 'when requesting a template' do
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
  end

end
