class CreateLoanRequests < ActiveRecord::Migration
  def change
    create_table :loan_requests do |t|
      t.string :amount
      t.string :duration
      
      t.string :loan_purpose
      t.integer :user_id
       

      t.timestamps null: false
    end
  end
end
