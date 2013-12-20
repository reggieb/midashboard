module ApplicationHelper
  
  def login_link
    if user_signed_in?
      text = "Logged in as #{current_user.email}"
      link = link_to('Logout', destroy_user_session_path, :method => :delete) 
      [text, link].join(' ').html_safe
    else
      link_to('Login', new_user_session_path) 
    end
  end
  
end
