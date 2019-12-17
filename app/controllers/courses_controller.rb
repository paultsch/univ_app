class CoursesController < ApplicationController
skip_before_action :require_user
before_action :set_course, only: [:edit, :show, :update, :destroy]
before_action :require_admin, only: [:new, :create, :destroy]
before_action :require_admin_or_teacher, only: [:edit, :update]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = "#{@course.name} has been created!"
      redirect_to courses_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @course.update(course_params)
      flash[:notice] = "#{@course.name} has been updated"
      redirect_to courses_path
    else
      redirect_to course_path(@course)
    end
  end

  def show

  end

  def destroy
    @course.destroy
    flash[:notice] = "#{@course.name} has been deleted"
    redirect_to courses_path
  end

private
  def course_params
    params.require(:course).permit(:short_name, :name, :description)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def require_admin
    if !logged_in? || !current_user.admin?
      flash[:notice] = "Only admin users can perform that action"
      redirect_to courses_path
    end
  end

  def require_admin_or_teacher
    if !logged_in? && (!current_user.teacher? || !current_user.admin?)
      flash[:notice] = "Only admin or teachers can perform that action"
      redirect_to courses_path
    end
  end

end
