class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user
  end



  def create
    begin
      omniauth = request.env["omniauth.auth"]
      #session[:fb_token] = omniauth["credentials"]["token"] if omniauth['provider'] == 'facebook'
      uid = current_user.try(:id)
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

      if authentication && session[:chang_avatar]
        if omniauth['credentials']['token']
          authentication.token = omniauth['credentials']['token']
          authentication.save
        end
        redirect_to "/set_avatar/#{authentication.provider_name.titleize}?image=#{omniauth['info']['image']}"
      elsif authentication
        if omniauth['credentials']['token']
          authentication.token = omniauth['credentials']['token']
          authentication.save
        end
        sign_in_and_redirect(authentication.user)
      elsif current_user
        current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'] ? omniauth['credentials']['token'] : "" )
        flash[:notice] = "Authentication successful."
        redirect_to edit_user_registration_url(tab:"social_media")
      else
        user = User.find_by_email(omniauth['info']['email'])
        if user.present?
          user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'] ? omniauth['credentials']['token'] : "" )
        else
          user = User.new
          user.set_uuid_pwd
          user.apply_omniauth(omniauth)
        end
        if user.save
          sign_in_and_redirect(user)
        else
          flash[:alert] = "Please enter the missing information to complete the registration"
          session[:images_omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url(:auth => true)
        end
      end
    rescue Exception => ex
      Rails.logger.debug ex.message
    end
  end



  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroy authentications."
    redirect_to edit_user_registration_url(tab: "social_media")
  end

  def failure
    render :text => "Login Failure!"
  end
end
