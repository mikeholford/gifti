module API
  module V1
    class Vouchers < Grape::API
      include API::V1::Defaults

      resource :vouchers do

        desc "Create a voucher"
        params do
          requires :template_id, type: String, desc: "ID of the voucher"
          requires :value, type: String, desc: "Value of the voucher"
          requires :discount_type, type: String, desc: "Discount Type of the voucher"
          requires :service, type: String, desc: "Service of the voucher"
        end

        post "/new", root: :vouchers do
          authenticate!
          record_api_request("post", "/new", "Create a voucher")

          design = Design.find_by_template(params[:template_id])

          voucher = Voucher.create!(
            user_id: api_user.id,
            design_id: design.id,
            heading: params[:heading],
            sub_heading: params[:sub_heading],
            value: params[:value],
            for: params[:for],
            code: params[:code],
            valid_until: params[:valid_until],
            discount_type: params[:discount_type],
            service: params[:service]
          )

          result = {
            voucher_id: voucher.ref,
            template_id: voucher.design.template,
            heading: voucher.heading,
            sub_heading: voucher.sub_heading,
            value: voucher.value,
            discount_type: voucher.discount_type,
            for: voucher.for,
            code: voucher.code,
            valid_until: voucher.valid_until,
            service: voucher.service,
            image_url: voucher.image_url
          }
          render result
        end


        desc "Schedule a voucher"
        params do
          requires :from, type: String, desc: "Value of the voucher"
          requires :for_email, type: String, desc: "Discount Type of the voucher"
          requires :send_on, type: String, desc: "Service of the voucher"
        end

        post "/:id/schedule", root: :vouchers do
          authenticate!
          record_api_request("post", "/:id/schedule", "Schedule a voucher")

          voucher = Voucher.find_by_ref(params[:id])

          if voucher.scheduled?
            error!('Voucher already scheduled, request a schedule update', 401)
          else
            voucher.update!(
              from: params[:from],
              for_email: params[:for_email],
              send_at: params[:send_on],
              message: params[:message],
              scheduled: true
            )
            result = {
              voucher_id: voucher.ref,
              send_on: voucher.send_at,
              scheduled: true
            }
            render result
          end
        end

      end
    end
  end
end
