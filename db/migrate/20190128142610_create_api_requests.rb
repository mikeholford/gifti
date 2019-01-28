class CreateApiRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :api_requests do |t|
      t.integer :api_access_id
      t.string :request_type
      t.string :path
      t.string :description

      t.timestamps
    end
  end
end
