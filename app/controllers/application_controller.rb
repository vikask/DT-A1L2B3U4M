class ApplicationController < ActionController::Base


  #========================================
  #created on 28 february
  #========================================
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user

  rescue_from CanCan:: AccessDenied do |exception|
    redirect_to :root_path,  :alert => exception.message
  end

  def authenticate_admin_user
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "This area is restricted to administrator only."
      redirect_to root_url
    end
  end

  def current_admin_user
    retrun nil if user_sign_in? && !current_admin_user?
    current_user
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  #def facebook_logout
  #  session[:user_id] = nil
  #  split_token = session[:fb_token].split("|")
  #  fb_api_key = split_token[0]
  #  fb_session_key = split_token[1]
  #  Rails.logger.info"*********facebook #{fb_api_key} and #{fb_session_key}"
  #  redirect_to "http://www.facebook.com/logout.php?api_key=#{fb_api_key}&session_key=#{fb_session_key}&confirm=1";
  #  flash[:notice] = "Successfully destroy authentications."
  #end

end
