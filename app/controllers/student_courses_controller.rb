class StudentCoursesController < ApplicationController

def create
   course_to_add = Course.find(params[:course_id])
   unless current_user.courses.include?(course_to_add)
     StudentCourse.create(course: course_to_add, student: current_user)
     flash[:notice] = "You have successfully enrolled in #{course_to_add.name}"
     redirect_to current_user
   else
     flash[:notice] = "Something was wrong with your enrollment."
     redirect_to courses_path
   end
end

def destroy
  course_to_delete = Course.find(params[:course_id])
  line_to_delete = StudentCourse.find_by(course: course_to_delete, student: current_user)
  StudentCourse.delete(line_to_delete.id)
  flash[:notice] = "#{current_user.name} has been unenrolled from #{course_to_delete.name}."
  redirect_to current_user
end

end
