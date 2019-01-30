module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::JSONAPIResources

        helpers do
          def permitted_params
            @permitted_params ||= declared(params,include_missing: false)
          end

          def logger
            Rails.logger
          end

          def authenticate!
            error!('401 Unauthorized', 401) unless api_user.present?
          end

          def api_user
            access = ApiAccess.find_by_key(headers['Authorization'])
            access.present? && access.live? ? access.user : nil
          end

          def record_api_request(request_type, path, desc)
            access = ApiAccess.find_by_key(headers['Authorization'])
            ApiRequest.create(api_access_id: access.id, request_type: "#{request_type}", path: "#{path}", description: "#{desc}")
            update_request_count(access)
          end

          def update_request_count(access)
            if access.request_count.present?
              access.update(request_count: access.request_count += 1)
            else
              access.update(request_count: 1)
            end
          end

        end

        before do
          access = ApiAccess.find_by_key(headers['Authorization'])
          if access.present?
            if ApiRequest.where(api_access_id: access.id).where(created_at: 1.hour.ago..Time.now).count >= 200
              error!('Hourly rate limit exceeded', 401)
            elsif ApiRequest.where(api_access_id: access.id).where(created_at: 1.month.ago..Time.now).count >= 20000
              error!('Monthly rate limit exceeded', 401)
            end
          end
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end
