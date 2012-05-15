require 'spec_helper'

describe ProductsController do
  
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

describe ProductsController, "Create Product" do

  before(:each) do
     @admin = Factory(:admin, :account => Factory(:account1))
     session[:account_id] = @admin.account.id
     @product = mock_model(Product)
  end  
  
  it "should allow admin to access new product page" do
    Product.should_receive(:new).and_return(@product)
    get :new
    response.should be_success
    response.should render_template 'new'
  end
  
  it "should allow admin to create product with valid data" do
    Product.should_receive(:new).and_return(@product)
    @product.should_receive(:save).and_return(true)
    post :create, :product => {:name => '', :description => '',:price =>'',:quantity => '', :weight =>'',:dimension =>'',:sku => '',:category_id =>''}
    response.should be_redirect
    response.should redirect_to edit_product_path(@product)
  end
    
  it "should show error messages if admin has tried to create a product with invalid data" do
    Product.should_receive(:new).and_return(@product)
    @product.should_receive(:save).and_return(false)
    post :create, :product => {:name => '', :description => '',:price =>'',:quantity => '', :weight =>'',:dimension =>'',:sku => '',:category_id =>''}
    response.should be_success
    response.should render_template 'new'
  end

end

describe ProductsController,"Update Product" do
  
  before(:each) do
     controller.stub!(:authorize_as_admin).and_return(true)
     @product = mock_model(Product , :id => 1 ,:save => true)
  end  
  
  it "should allow admin to access edit action" do
    Product.should_receive(:find_by_id).and_return(@product)
    get :edit
    response.should be_success
    response.should render_template "edit"
  end  
  
  it "should show error messages if admin tried to create product with invalid data" do
    Product.should_receive(:find_by_id).and_return(@product)
    @product.should_receive(:update_attributes).and_return(false)
    put :update, :product => {:name => '', :description => '',:price =>'',:quantity => '', :weight =>'',:dimension =>'',:sku => '',:category_id =>''}
    response.should be_success
    response.should render_template 'edit'
  end  
  
  it "should allow admin to create product with valid data" do
    Product.should_receive(:find_by_id).and_return(@product)
    @product.should_receive(:update_attributes).and_return(true)
    put :update, :product => {:name => '', :description => '',:price =>'',:quantity => '', :weight =>'',:dimension =>'',:sku => '',:category_id =>''}
    response.should be_redirect
    response.should redirect_to products_path
  end
end  

describe ProductsController do
  
  before(:each) do
     @admin = Factory(:admin, :account => Factory(:account1))
     session[:account_id] = @admin.account.id
     @product = mock_model(Product, :id => 1, :save => true)
  end
  
  it "should allow admin to access index action" do
     Product.should_receive(:all).and_return(@products)
     get :index
     response.should be_success
     response.should render_template 'products/admin_index'
   end
   
   it "should allow admin to delete a product" do
     Product.should_receive(:find_by_id).and_return(@product)
     @product.should_receive(:destroy).and_return(true)
     delete :destroy, {:id => 1}
     response.should redirect_to products_path
   end
   
   it "should allow admin to upload valid image for product" do
     @image = mock_model(Image)
     Product.should_receive(:find_by_id).and_return(@product)
     Image.should_receive(:new).and_return(@image)
     @product.should_receive(:image_type).and_return([])
     @image.should_receive(:valid?).and_return(true)
     @image.should_receive(:kind=).and_return(true)
     @image.should_receive(:save).and_return(true)
     post :upload_photo , {:photo =>{:uploaded_data => ''} , :kind => 1}
     response.should redirect_to edit_product_path(@product)
   end    
   
   it "should not allow admin to upload invlaid image for product" do
       @image = mock_model(Image)
       Product.should_receive(:find_by_id).and_return(@product)
        Image.should_receive(:new).and_return(@image)
        @image.should_receive(:valid?).and_return(false)
        post :upload_photo , {:photo =>{:uploaded_data => ''} , :kind => 1}
        response.should render_template 'edit'
    end   
end  


describe ProductsController do
    
  before(:each) do
    @product = mock_model(Product, :id => 1, :save => true)
  end          
  
  it "should allow visitor to access index action" do
    Product.should_receive(:all).and_return(@products)
    get :index
    response.should render_template 'index'
  end      
    
  it "should allow visitor to access show action" do
    Product.should_receive(:find_by_id).and_return(@product)
    get :show ,{:id => @product.id}
    response.should render_template 'show'
  end
  
  it "should redirect to products index page if product with a id is not found" do
     Product.should_receive(:find_by_id).and_return()
     get :show ,{:id => ''}
     response.should redirect_to products_path
  end
  
  it "should allow user to add a product to his cart" do
      @cart = mock_model(Cart)
      Product.should_receive(:find_by_id).and_return(@product)
      @cart.should_receive(:add_product).and_return(true)
      post :add_to_cart
      response.should redirect_to products_path
  end      
end  