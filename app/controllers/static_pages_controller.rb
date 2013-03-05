class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def contact
  end


    def change_picture
      @user = current_user
      if request.xhr?
        if request.delete?
          @user.picture = nil
          @user.save
        else
          @user.update_attributes(params[:user])
        end
        render :json => [@user.to_jq_upload].to_json, :content_type => 'text/plain', :layout => false
      else
        @user.update_attributes(params[:user])
        redirect_to "/users/edit?tab=profile"
      end
    end

  end

