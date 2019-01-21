class AddViewportToDesign < ActiveRecord::Migration[5.2]
  def change
    add_column :designs, :height, :integer
    add_column :designs, :width, :integer
  end
end
