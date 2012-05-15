# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  layout :layout_type

  # render new.rhtml
  def new
    unless session[:account_id].blank?
      redirect_to root_path
    end  
  end

  def create
    account = Account.authenticate(params[:email], params[:password])
    if account && account.activation_token.blank?       
      self.current_account = account
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      if current_account.admin?
        @admin = Admin.find_by_id(current_account.resource_id)
        return redirect_to categories_path
      else
        if session[:return_to].blank?
          return redirect_to user_path(current_account.resource_id)
        else
          return redirect_to session[:return_to]
        end  
      end  
    else
      @email       = params[:email]
      @remember_me = params[:remember_me]
      flash.now[:notice] = "Invalid Email or Password"
      return render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

end
