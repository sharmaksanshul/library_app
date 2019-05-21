class CreateIssueDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :issue_details do |t|
      t.integer :student_id
      t.integer :book_id
      t.date :issue_date
      t.date :exp_recieved_date
      t.date :act_recieved_date
      t.integer :fine

      t.timestamps
    end
    add_index :issue_details, :student_id
    add_index :issue_details, :book_id
    add_index :issue_details, [:book_id, :student_id]
  end
end
