require 'rails_helper'

describe API::V1::Vouchers do

  let(:api_access) { FactoryBot.create :api_access }

  describe '/voucher/new' do
    context 'rendering a voucher' do
      before do
        @required = {
          template: (FactoryBot.create :design).template,
          value: Faker::Number.number(2),
          discount_type: "%",
          service: Faker::Company.name}
      end
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
  end

  describe '/voucher/:id/schedule' do
    context 'scheduling a voucher' do
      let(:voucher) { FactoryBot.create :voucher }
      before do
        @required = {
          from: Faker::Name.name,
          for_email: Faker::Internet.email,
          send_on: Faker::Date.between(Date.today, (Date.today + 2.months))}
      end
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
  end

end
