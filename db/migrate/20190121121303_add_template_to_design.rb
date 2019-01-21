class AddTemplateToDesign < ActiveRecord::Migration[5.2]
  def change
    add_column :designs, :template, :string
  end
end
