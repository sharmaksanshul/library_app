class AddNameToBookKeeper < ActiveRecord::Migration[5.2]
  def change
    add_column :book_keepers, :name, :string
  end
end
