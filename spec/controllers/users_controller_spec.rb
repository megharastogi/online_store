require 'spec_helper'

describe UsersController do

  it "should allow logged in user to access show action" do
    controller.stub!(:authorize).and_return(true)
    @account = mock_model(Account , :id => 2 , :email => 'user@gmail.com')
    controller.stub!(:current_user).and_return(@account)
    get :show
    response.should render_template 'show'
  end

end


describe UsersController do
  
  before(:each) do
    @user = mock_model(User)
    @account = mock_model(Account , :id => 1 ,:save => true)
  end  
  
  it "should allow visitor to access new action" do
    User.should_receive(:new).and_return(@user)
    get :new
    response.should be_success
    response.should render_template 'new'
  end  
  
  it "should not allow visitor to create a user with invalid data" do
    User.should_receive(:new).and_return(@user)
    @user.should_receive(:save).and_return(false)
    post :create , :user => { :account_attributes => {:email => '',:name => '', :password => '', :password_confirmation => ''}}
    response.should be_success
    response.should render_template 'new'
  end  
  
  it "should allow visitor to create a user with valid data" do
    User.should_receive(:new).and_return(@user)
    @user.should_receive(:save).and_return(true)
    @user.should_receive(:account).and_return(@account)
    @account.should_receive(:generate_activation_token).and_return(true)
    post :create , :user => { :account_attributes => {:email => '',:name => '', :password => '', :password_confirmation => ''}}
    response.should be_redirect
    response.should redirect_to root_path
    flash[:notice].should == "Please check you mail for the activation link"
  end  
  
end