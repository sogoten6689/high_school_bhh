class AddDifficultAreaToRelationships < ActiveRecord::Migration[6.1]
  def change
    add_column :relationships, :difficult_area, :integer
    add_column :relationships, :difficult_code, :string
    add_column :relationships, :revolutionary_family, :integer, default: 0
  end
end
