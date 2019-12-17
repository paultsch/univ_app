class AddDetailsToStudents < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :admin, :boolean
    add_column :students, :teacher, :boolean
    add_column :students, :student, :boolean
  end
end
