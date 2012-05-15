require 'spec_helper'

describe CategoriesController do

  after(:each) do
    response.should_not be_success
    response.should be_redirect
  end
  
  it "should not allow visitor to access new action" do
    get :new
  end
  
  it "should not allow visitor to access destroy action" do
    delete :destroy
  end
  
  it "should not allow visitor to access create action" do
    post :create
  end
  
  it "should not allow visitor to access edit action" do
    get :edit
  end
  
  it "should not allow visitor to access update action" do
    put :update
  end
  
end

describe CategoriesController, "Create category" do

  before(:each) do
    controller.stub!(:authorize_as_admin).and_return(true)
    @category = mock_model(Category)
  end  
  
  it "should allow admin to access new action" do
    Category.should_receive(:new).and_return(@category)
    get :new
    response.should be_success
    response.should render_template 'new'
  end  
  
  it "should show error messages if admin has tried to create a category with invalid data" do
    Category.should_receive(:new).and_return(@category)
    @category.should_receive(:save).and_return(false)
    post :create, :category => {:name =>'', :description => ''}
    response.should be_success
    response.should render_template 'new'
  end  
  
  it "should allow admin to create category with valid data" do
    Category.should_receive(:new).and_return(@category)
    @category.should_receive(:save).and_return(true)
    post :create, :category => {:name => '', :description => ''}
    response.should be_redirect
    response.should redirect_to categories_path
    flash[:notice].should == "Category has been created successfully."
  end
  
end


describe CategoriesController, "Update category" do

  before(:each) do
    controller.stub!(:authorize_as_admin).and_return(true)
    @category = mock_model(Category , :id => 1 , :save => true)
  end
  
  it "should allow admin to access edit action" do
    Category.should_receive(:find_by_id).and_return(@category)
    get :edit
    response.should be_success
    response.should render_template 'edit'
  end  

  it "should show error messages if admin has tried to update category with invalid data" do
    Category.should_receive(:find_by_id).and_return(@category)
    @category.should_receive(:update_attributes).and_return(false)
    post :update , :category => {:name => '', :description => ''}
    response.should be_success
    response.should render_template 'edit'
  end
  
  it "should allow admin to update category with valid data" do
    Category.should_receive(:find_by_id).and_return(@category)
    @category.should_receive(:update_attributes).and_return(true)
    post :update , :category => {:name => '', :description => ''}
    response.should be_redirect
    response.should redirect_to categories_path
  end
    
end 


describe CategoriesController do
  
  before(:each) do
    controller.stub!(:authorize_as_admin).and_return(true)
    @category = mock_model(Category , :id => 1 , :save => true)
    @categories = [@category]
  end  
  
  it "should admin to access index action" do
    Category.should_receive(:find).and_return(@categories)
    get :index
    response.should be_success
    response.should render_template 'index'
  end  
  
  it "should allow admin to delete a category" do
    Category.should_receive(:find_by_id).and_return(@category)
    @category.should_receive(:destroy).and_return(true)
    delete :destroy, {:id => 1}
    response.should redirect_to categories_path
  end  

end    


describe CategoriesController do
  
  before(:each) do
    @category = mock_model(Category , :id => 1 , :save => true)
    @product = mock_model(Product ,:id => 1 ,:category_id => 1 ,:save => true)
  end 
  
  it "should allow visitor/user to access show action" do
    Category.should_receive(:find_by_id).and_return(@category)
    Product.should_receive(:find).and_return([])
    get :show , {:id => @category.id}
    response.should render_template 'show'
  end  
  
  it "should redirect user to category index page if any category dosent exists" do
    Category.should_receive(:find_by_id).and_return(nil)
    get :show , {:id => 'sd'}
    response.should redirect_to categories_path
  end      
end  