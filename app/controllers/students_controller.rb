class StudentsController < ApplicationController
skip_before_action :require_user, only: [:new, :create]
before_action :set_student, only: [:show, :edit, :update, :destroy]
before_action :require_same_student, only:[:edit, :update, :destroy]
before_action :require_admin, only:[:destory]

  def index
    @students = Student.where(student: true)
    @teachers = Student.where(teacher: true)
    @admins = Student.where(admin: true)
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      session[:student_id] = @student.id
      flash[:notice] = "You have successfully signed up #{@student.name}"
      redirect_to student_path(@student)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      flash[:notice] = "You have successfully updated #{@student.name}"
      redirect_to student_path(@student)
    else
      render 'edit'
    end
  end

  def destroy
    @student.destroy
    flash[:notice] = "#{@student.name} has been deleted"
    redirect_to students_path
  end

private
  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def require_same_student
    if current_user != @student && !current_user.admin?
      flash[:danger] = "You can only edit your own account"
      redirect_to edit_student_path(current_user)
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:notice] = "Only admin users can perform that action"
      redirect_to students_path
    end
  end

end
