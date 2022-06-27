class CreateSecondarySchoolUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :secondary_school_users do |t|
      t.string :school_name
      t.string :school_type
      t.string :other_language
      t.float :math
      t.float :physics
      t.float :chemistry
      t.float :biological
      t.float :literature
      t.float :history
      t.float :geography
      t.float :english
      t.float :civic_education
      t.float :technology
      t.float :subject_average
      t.float :admission_test_score
      t.string :exercise_result
      t.string :ranked_academic
      t.string :conduct
      t.boolean :editable, default: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
