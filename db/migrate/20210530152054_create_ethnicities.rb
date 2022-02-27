class CreateEthnicities < ActiveRecord::Migration[6.1]
  def change
    create_table :ethnicities do |t|
      t.string :name
      t.integer :code
      t.string :ethnicity_slug
      t.timestamps
    end
  end
end
