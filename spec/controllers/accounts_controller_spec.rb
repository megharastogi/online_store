require 'spec_helper'

describe AccountsController do

   before(:each) do
    @account = mock_model(Account)
   end   

   it "should allow visitor to access new action" do
     Account.should_receive(:new).and_return(@account)
     get :new
     response.should be_success
   end 
   
   it "should not allow visitor to create account with invalid data" do
     Account.should_receive(:new).and_return(@account)
     @account.should_receive(:save).and_return(false)
     post :create , :account => {:name =>'', :email => '', :password => '' , :password_confirmation => ''}
     response.should be_success
     response.should render_template 'new'
   end 
   
   it "should allow visitor to create account with valid data" do
     Account.should_receive(:new).and_return(@account)
     @account.should_receive(:save).and_return(true)
     post :create , :account => {:name =>'', :email => '', :password => '' , :password_confirmation => ''}
     response.should be_redirect
     response.should redirect_to root_path
     flash[:notice].should == "Thanks for signing up!"
   end
   
   it "should not allow a visitor to access settings action" do
      get :settings
      response.should be_redirect 
      response.should redirect_to login_path
      flash[:notice].should == "You must be logged in"
   end
    
   it "should not allow a visitor to access change_password action" do
     post :change_password
     response.should be_redirect 
     response.should redirect_to login_path
     flash[:notice].should == "You must be logged in"
   end   
end

describe AccountsController do
  
  before(:each) do
    @account = mock_model(Account , :id => 2 , :email => "user@gmail.com" ,:password => 'pass123' , :password_confirmation => 'pass123', :save => true)
  end  
  
  it "should show proper error message if reset password link is not containing reset token" do
    get :reset_password, {:reset_token => nil}
    response.should be_redirect
    response.should redirect_to root_path
    flash[:notice].should == "Invalid URL"
  end
  
  it "should show proper error message if reset password link contains invalid reset token" do
    Account.should_receive(:find_by_reset_token).and_return(nil)
    get :reset_password, {:reset_token => 'invalid_token'}
    response.should be_redirect
    response.should redirect_to root_path
    flash[:notice].should == "Invalid URL"
  end
  
  it "should allow user to view reset password page with valid reset token" do
    Account.should_receive(:find_by_reset_token).and_return(@account)
    get :reset_password, {:reset_token => 'akjkjhasdkjhkjaddsa'}
    response.should be_success
    response.should render_template "reset_password"
  end  
  
  it "should allow user to reset password with valid password values" do
    Account.should_receive(:find_by_reset_token).and_return(@account)
    @account.should_receive(:update_attributes).and_return(true)
    @account.should_receive(:update_attribute).and_return(true)
    post :reset_password, {:reset_token => 'akjkjhasdkjhkjaddsa', :account => {:password => 'pass123', :password_confirmation => 'pass123'}}
    response.should be_redirect
    response.should redirect_to root_path
  end
  
  it "should not allow user to reset password with invalid password values" do
    Account.should_receive(:find_by_reset_token).and_return(@account)
    @account.should_receive(:update_attributes).and_return(false)
    post :reset_password, {:reset_token => 'akjkjhasdkjhkjaddsa', :account => {:password => 'pass123', :password_confirmation => 'pass'}}
    response.should be_success
    response.should render_template 'reset_password'
  end
  
  it "should allow visitor to access forgot password action" do
    get :forgot_password
    response.should be_success
    response.should render_template "forgot_password"
  end

  it "should show error message if visitor enters invalid email" do
    Account.should_receive(:find_by_email).and_return(nil)
    post :send_reset_link , {:user_email => 'invalid_email'}
    response.should redirect_to forgot_password_path
    flash[:notice].should == "No user account found"
  end  
  
  it "should send reset token in mail to user if visitor has entered valid email" do
       Account.should_receive(:find_by_email).and_return(@account)
       @account.should_receive(:generate_reset_token).and_return(true)
       post :send_reset_link , {:user_email => 'user@gmail.com'}
       response.should redirect_to root_path
       flash[:notice].should == "Please check your email to reset your password."
  end
  
  it "should allow visitor to activate its account by giving correct activation link" do
      Account.should_receive(:find_by_activation_token).and_return(@account)
      @account.should_receive(:update_attribute).and_return(true)
      post :activate_user , {:activation_token => "asdasda"}
      response.should redirect_to user_path(@account.id)
  end 
  
  it "should not allow visitor to access activate_user action with invlaid activation_token" do
    Account.should_receive(:find_by_activation_token).and_return(nil)
    post :activate_user , {:activation_token => ""}
    response.should redirect_to root_path
    flash[:notice].should == "Your activation token is not valid."
  end      
end  
  

describe AccountsController do

   before(:each) do
     controller.stub!(:authorize).and_return(true)
     @account = mock_model(Account , :name => "abcd",:id => 1 , :email => "user@gmail.com" ,:password => 'pass123' , :password_confirmation => 'pass123', :save => true)
     controller.stub!(:current_account).and_return(@account)
   end

   it "should allow logged in user access settings action" do
     get :settings
     response.should be_success
     response.should render_template 'settings'
   end 
   
   it "should not allow user to change password if old password is not correct" do
      @account.should_receive(:authenticated?).and_return(false)
      put :change_password , {:old_password => '' , :account => {:password => '', :password_confirmation => ''}}
      response.should be_redirect
   end   
      
    it "should allow user to change password with valid data if old password is correct" do
        @account.should_receive(:authenticated?).and_return(true)
        @account.should_receive(:update_attributes).and_return(true)
        put :change_password , {:old_password => '' , :account => {:password => '', :password_confirmation => ''}}
        response.should be_redirect
     end
     
     it "should not allow user to change password with invalid data if old password is correct" do
         @account.should_receive(:authenticated?).and_return(true)
         @account.should_receive(:update_attributes).and_return(false)
         put :change_password , {:old_password => '' , :account => {:password => '', :password_confirmation => ''}}
         response.should render_template 'settings'
      end
end   
   