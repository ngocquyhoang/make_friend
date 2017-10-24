class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :type
      t.integer :activity_target
      t.integer :user_id

      t.timestamps
    end
  end
end
