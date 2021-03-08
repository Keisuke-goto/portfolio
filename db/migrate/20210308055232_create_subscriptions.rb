class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.integer :upload_id
      t.integer :user_id

      t.timestamps
    end
  end
end
