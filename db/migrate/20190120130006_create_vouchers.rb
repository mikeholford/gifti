class CreateVouchers < ActiveRecord::Migration[5.2]
  def change
    create_table :vouchers do |t|
      t.string :name
      t.string :heading
      t.string :sub_heading
      t.float :value
      t.string :for
      t.string :code

      t.timestamps
    end
  end
end
