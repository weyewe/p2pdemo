class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
       
      t.integer :user_id 
      t.string :first_name
      t.string :last_name 
      t.string :fb_profile_image_url 
      t.string :app_specific_facebook_url
      
       
        
        
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :sex
      t.integer :children
      
      
      # Address
      
      t.string :address
      t.string :city
      t.string :country
      t.string :zipcode
      
      
      # Contact
      t.string :mobile_phone
      
      # withdrawal bank account
      t.string :bank_account_name
      t.string :bank_account_no
      t.string :bank_name
      t.string :bank_branch_name
      
      # uploaded file
      t.string :id_card_url
      t.string :family_card_url
      t.string :salary_receipt_url 
      t.string :other_proof_url 
      t.string :credit_card_bill_url

      t.timestamps null: false
    end
  end
end
