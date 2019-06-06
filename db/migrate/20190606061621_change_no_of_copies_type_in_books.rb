class ChangeNoOfCopiesTypeInBooks < ActiveRecord::Migration[5.2]
  def change
  	change_column :books, :no_of_copies, :integer
  end
end
