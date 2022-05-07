class AddReligionColumnToTableUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :religion, :integer
    add_column :users, :another_religion, :string
  end
end
