class CreateElectiveSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :elective_subjects do |t|
      t.string :group_subject
      t.string :thematic_group
      t.string :elective_subject_one
      t.string :elective_subject_two
      t.string :alternative_subject
      t.boolean :editable, default: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
