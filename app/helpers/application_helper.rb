module ApplicationHelper

  def session_link
    if (logged_in?)
      link_to("Logout", logout_path, method: :delete)
    else
      link_to("Login", login_path)
    end
  end

  def account
    if (logged_in?)
      link_to("#{@current_user.name}'s Account", student_path(@current_user))
    else
      link_to("Sign Up", sign_up_path)
    end
  end


end
