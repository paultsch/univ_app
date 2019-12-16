class SessionsController < ApplicationController
skip_before_action :require_user, only: [:new, :create, :destroy]

  def new

  end

  def create
    student = Student.find_by(email: params[:session][:email].downcase)
    if student && student.authenticate(params[:session][:password])
      session[:student_id] = student.id
      flash[:notice] = "Welcome #{student.name}!"
      redirect_to student_path(student.id)
    else
      flash.now[:notice] = "There was something wrong with your credentials"
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path
  end

end
