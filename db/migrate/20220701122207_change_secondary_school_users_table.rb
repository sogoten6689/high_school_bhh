class ChangeSecondarySchoolUsersTable < ActiveRecord::Migration[6.1]
  def change
    add_column :secondary_school_users, :math_semester_one, :float
    add_column :secondary_school_users, :math_semester_two, :float

    add_column :secondary_school_users, :physics_semester_one, :float
    add_column :secondary_school_users, :physics_semester_two, :float

    add_column :secondary_school_users, :chemistry_semester_one, :float
    add_column :secondary_school_users, :chemistry_semester_two, :float

    add_column :secondary_school_users, :biological_semester_one, :float
    add_column :secondary_school_users, :biological_semester_two, :float

    add_column :secondary_school_users, :literature_semester_one, :float
    add_column :secondary_school_users, :literature_semester_two, :float

    add_column :secondary_school_users, :history_semester_one, :float
    add_column :secondary_school_users, :history_semester_two, :float

    add_column :secondary_school_users, :geography_semester_one, :float
    add_column :secondary_school_users, :geography_semester_two, :float

    add_column :secondary_school_users, :english_semester_one, :float
    add_column :secondary_school_users, :english_semester_two, :float

    add_column :secondary_school_users, :civic_education_semester_one, :float
    add_column :secondary_school_users, :civic_education_semester_two, :float

    add_column :secondary_school_users, :technology_semester_one, :float
    add_column :secondary_school_users, :technology_semester_two, :float
  end
end
