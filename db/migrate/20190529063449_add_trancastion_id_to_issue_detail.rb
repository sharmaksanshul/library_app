class AddTrancastionIdToIssueDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :issue_details, :transaction_id, :string
  end
end
