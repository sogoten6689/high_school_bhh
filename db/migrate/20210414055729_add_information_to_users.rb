class AddInformationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :name, :string
    add_column :users, :gender, :integer
    add_column :users, :birthday, :date
    add_column :users, :province, :integer
    add_column :users, :ethnicity, :integer
    add_column :users, :another_ethnicity, :string
    add_column :users, :identification, :string
    add_column :users, :identification_image, :string
    add_column :users, :student_code, :string
    add_column :users, :role, :integer, default: 0

  end
end
