module API
  module V1
    class Templates < Grape::API
      include API::V1::Defaults

      resource :templates do

        desc "Return all templates"
        get "", root: :templates do
          authenticate!
          record_api_request("get", "/templates", "Return all templates")

          Design.all
        end

        desc "Return a template"
        # params do
        #   requires :id, type: String, desc: "ID of the template"
        # end
        get "/:id", root: "template" do
          authenticate!
          record_api_request("get", "/templates/:id", "Return a template")

          Design.where(template: params[:id]).first!
        end
      end
    end
  end
end
