class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.integer :request_user_id
      t.integer :receive_user_id
      t.boolean :is_accept, default: false

      t.timestamps
    end
    add_index :relationships, :request_user_id
    add_index :relationships, :receive_user_id
    add_index :relationships, [:request_user_id, :receive_user_id], unique: true
  end
end
