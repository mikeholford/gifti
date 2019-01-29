class AddTemplateImageToDesign < ActiveRecord::Migration[5.2]
  def change
    add_column :designs, :template_image, :string
  end
end
