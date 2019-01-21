json.extract! voucher, :id, :name, :heading, :sub_heading, :value, :for, :code, :created_at, :updated_at
json.url voucher_url(voucher, format: :json)
