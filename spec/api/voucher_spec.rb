require 'rails_helper'

describe API::V1::Vouchers do

  let(:api_access) { FactoryBot.create :api_access }

  describe '/voucher/new' do
    before do
      @required = {template: (FactoryBot.create :design).template, value: Faker::Number.number(2), discount_type: "%", service: Faker::Company.name}
    end
    context 'authenticated user creates a voucher' do
      it 'returns correct ID and service' do
        post "/api/v1/vouchers/new", params: {template_id: @required[:template], value: @required[:value], discount_type: @required[:discount_type], service: @required[:service]}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)['voucher_id']).to eq(Voucher.last.ref)
        expect(JSON.parse(response.body)['service']).to eq(@required[:service])
      end
      it 'confirms params missing' do
        post "/api/v1/vouchers/new", params: {}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)['error']).to include("is missing")
      end
    end
    context 'unuthenticated user creates a voucher' do
      it 'returns an authentication error' do
        post "/api/v1/vouchers/new", params: {template_id: @required[:template], value: @required[:value], discount_type: @required[:discount_type], service: @required[:service]}, headers: { 'Authorization' => "" }
        expect(JSON.parse(response.body)["error"]).to eq("401 Unauthorized")
      end
    end
  end

  describe '/voucher/:id/schedule' do
    let(:voucher) { FactoryBot.create :voucher }
    before do
      @required = {from: Faker::Name.name, for_email: Faker::Internet.email, send_on: Faker::Date.between(Date.today, (Date.today + 2.months))}
    end
    context 'scheduling a new voucher' do
      it 'confirms voucher is scheduled' do
        post "/api/v1/vouchers/#{voucher.ref}/schedule", params: {from: @required[:from], for_email: @required[:for_email], send_on: @required[:send_on]}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)['voucher_id']).to eq(voucher.ref)
        expect(JSON.parse(response.body)['scheduled']).to be true
      end
      it 'confirms params missing' do
        post "/api/v1/vouchers/#{voucher.ref}/schedule", params: {}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)['error']).to include("is missing")
      end
    end
    context 'scheduling a scheduled voucher' do
      before do
        voucher.update_attribute('scheduled', true)
      end
      it 'returns a scheduling error' do
        post "/api/v1/vouchers/#{voucher.ref}/schedule", params: {from: @required[:from], for_email: @required[:for_email], send_on: @required[:send_on]}, headers: { 'Authorization' => api_access.key }
        expect(JSON.parse(response.body)["error"]).to eq("Voucher already scheduled")
      end
    end
  end

end
