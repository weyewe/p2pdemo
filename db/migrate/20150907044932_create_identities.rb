class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|

    t.string :username
    t.integer :user_id
    t.string :provider 
    t.string :uid
    t.string :access_token
     
      t.timestamps null: false
    end
  end
end
