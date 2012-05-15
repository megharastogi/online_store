class ProductsController < ApplicationController

  layout :layout_type
  
  before_filter :authorize_as_admin ,:except => [:index, :show, :add_to_cart]
  before_filter :load_product ,:only => [:edit, :update, :show, :destroy,:add_to_cart,:upload_photo]
    
  def index
    @products = Product.all
    render :template => "products/admin_index" if current_account && current_account.admin?
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_with_flash("notice", "Product successfully created", edit_product_path(@product))
    else
      render :action => "new"
    end    
  end
  
  def edit
    
  end
    
  def update
    if @product.update_attributes(params[:product])
      redirect_with_flash("notice", "Product has been updated", products_path)
    else
      render :action => "edit" 
    end   
  end
  
  def show
  end
  
  def destroy
    @product.destroy
    redirect_with_flash("notice", "Product has been deleted", products_path)
  end      
  
  def add_to_cart
     session[:cart].add_product(@product)
     respond_to do |format|
       if request.xhr?         
         format.js 
       else
         format.html{redirect_to products_path}
       end 
     end
   end
   
   def upload_photo
     @new_image = Image.new(params[:photo].merge({:record_type => "Product" , :record_id => params[:id]}))
     if @new_image.valid? 
         @product.image_type(params[:kind]).destroy unless @product.image_type(params[:kind]).blank?
         @new_image.kind = params[:kind].to_i  
         @new_image.save
         redirect_to edit_product_path(@product)
     else
         render :template => "products/edit"
     end     
   end   
   
  private
  
    def load_product
      @product = Product.find_by_id(params[:id])
      unless @product
        redirect_with_flash("notice", "Product does not exist", products_path)
      end
    end

end
