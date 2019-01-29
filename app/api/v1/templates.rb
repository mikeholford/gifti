module API
  module V1
    class Templates < Grape::API
      include API::V1::Defaults

      resource :templates do

        desc "Return all templates"
        get "", root: :templates do
          authenticate!
          record_api_request("get", "/templates", "Return all templates")
          result = Array.new
          Design.all.each do |d|
            result << {
              id: d.template,
              created_at: d.created_at,
              updated_at: d.updated_at,
              width: d.width,
              height: d.height,
              name: d.name,
              image: d.template_image_url
            }
          end
          render result
        end

        desc "Return a template"
        get "/:id", root: "template" do
          authenticate!
          record_api_request("get", "/templates/:id", "Return a template")
          design = Design.where(template: params[:id]).first!
          result = {
            id: design.template,
            created_at: design.created_at,
            updated_at: design.updated_at,
            width: design.width,
            height: design.height,
            name: design.name,
            image: d.template_image_url
          }
          render result
        end
      end
    end
  end
end
