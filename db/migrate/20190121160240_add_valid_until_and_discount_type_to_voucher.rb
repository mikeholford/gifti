class AddValidUntilAndDiscountTypeToVoucher < ActiveRecord::Migration[5.2]
  def change
    add_column :vouchers, :valid_until, :datetime
    add_column :vouchers, :discount_type, :string
  end
end
