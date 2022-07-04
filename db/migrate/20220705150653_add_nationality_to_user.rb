class AddNationalityToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nationality, :string
  end
end
