module API
  module V1
    class Base < Grape::API
      mount API::V1::Templates
      mount API::V1::Vouchers
    end
  end
end
