class DeviseCreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, unique: true, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :username,           null: false, unique: true, default: ""

      t.string :name
      t.string :avatar
      t.string :gender
      t.string :address_commune
      t.string :address_district
      t.string :address_province
      t.string :highschool_province
      t.string :highschool_district
      t.text :job
      t.text :hobby
      t.text :dislike
      t.text :high_school
      t.text :univesity
      t.datetime :dob
      t.boolean :is_verified,           default: false

      ## Recoverable
      t.string   :reset_password_token,               unique: true
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count,        default: 0,   null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token,   unique: true
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Lockable
      t.integer  :failed_attempts,      default: 0,   null: false
      t.string   :unlock_token,         unique: true
      t.datetime :locked_at

      ## Delete
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
