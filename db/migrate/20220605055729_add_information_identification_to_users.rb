class AddInformationIdentificationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :identification_type, :integer
    add_column :users, :identifier_code, :string
    add_column :users, :identification_chip, :integer, default: 0
    add_column :users, :health_insurance_code, :string
  end
end
