class CreateStudentClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :student_classes do |t|
      t.string :class_name
      t.integer :student_class_code
      t.integer :grade
      t.integer :year

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
