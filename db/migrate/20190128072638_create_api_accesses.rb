class CreateApiAccesses < ActiveRecord::Migration[5.2]
  def change
    create_table :api_accesses do |t|
      t.string :user_id
      t.string :name
      t.string :website_url
      t.string :description
      t.integer :request_count
      t.string :key
      t.boolean :live, default: true

      t.timestamps
    end
  end
end
