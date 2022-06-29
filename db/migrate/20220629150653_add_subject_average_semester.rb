class AddSubjectAverageSemester < ActiveRecord::Migration[6.1]
  def change
    add_column :secondary_school_users, :subject_average_semester_one, :float
    add_column :secondary_school_users, :subject_average_semester_two, :float
  end
end
