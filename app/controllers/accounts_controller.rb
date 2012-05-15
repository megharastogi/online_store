class AccountsController < ApplicationController

  
  before_filter :authorize , :only => [:settings,:change_password]
  
  def new
    @account = Account.new
  end
 
  def create
    logout_keeping_session!
    @account = Account.new(params[:account])
    if @account.save 
      self.current_account = @account
      flash[:notice] = "Thanks for signing up!"
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't set up that account, sorry."
      render :action => 'new'
    end
  end
  
  def reset_password
    @account = Account.find_by_reset_token(params[:reset_token])
    if params[:reset_token].blank? || @account.blank?
      return redirect_with_flash("notice", "Invalid URL", root_path)
    end
    if request.post?
      if @account.update_attributes(params[:account])
        @account.update_attribute('reset_token' , nil)
        return redirect_with_flash("notice", "Your Password has been updated", root_path)
      else
        render :action => "reset_password"
      end    
    end
  end
  
  def forgot_password
  
  end  
  
  def send_reset_link
    @user = Account.find_by_email(params[:user_email])
    if @user
      @user.generate_reset_token
      redirect_with_flash("notice", "Please check your email to reset your password.", root_path)    
    else
      redirect_with_flash("notice", "No user account found", forgot_password_path)
    end 
  end
  
  def settings

  end

  def change_password
     unless current_account.authenticated?(params[:old_password])
       return redirect_with_flash("error", "Please enter correct current password", settings_account_path(current_account))
     end
     if current_account.update_attributes(params[:account])
       redirect_with_flash("notice", "Your password has been updated.", user_path(current_account))
     else
       render :action => "settings"
     end
   end  

   def activate_user
       @account = Account.find_by_activation_token(params[:activation_token])
       if params[:activation_token].blank? || @account.blank?
         return redirect_with_flash("notice", "Your activation token is not valid.", root_path)
       end
       @account.update_attribute('activation_token' , nil)
       if session[:account_id].blank?
           session[:account_id] = @account.id
       end
       return redirect_to user_path(@account.id)
   end
  
end
