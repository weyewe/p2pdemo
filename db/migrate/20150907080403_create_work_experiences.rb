class CreateWorkExperiences < ActiveRecord::Migration
  def change
    create_table :work_experiences do |t|
      t.integer :borrower_profile_id 
      
      t.string :company
      t.string :position 
      t.string :monthly_salary
      t.string :duration
      
      
      t.string :address
      t.string :city
      t.string :country
      t.string :zipcode
      t.string :phone_number
      
      
      t.timestamps null: false
    end
  end
end
