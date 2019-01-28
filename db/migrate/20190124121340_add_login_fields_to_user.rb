class AddLoginFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :login_key, :string
    add_column :users, :login_key_sent, :datetime
  end
end
