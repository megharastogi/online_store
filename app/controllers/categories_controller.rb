class CategoriesController < ApplicationController
  layout :layout_type

  before_filter :authorize_as_admin , :except => [:index , :show ]
  before_filter :load_category, :only => [:edit, :update, :show, :destroy]

  def index
    render :template => "categories/admin_index" if current_account && current_account.admin?
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_with_flash("notice","Category has been created successfully.", categories_path)
    else
      render :action => "new"
    end
  end

  def edit
    
  end  

  def update
    if @category.update_attributes(params[:category])
      redirect_with_flash("notice","Category has been updated", categories_path)
    else
      render :action => "edit"
    end    
  end

  def show
    @products = Product.find(:all, :conditions => ['category_id = ?', @category.id])  
  end

  def destroy 
    @category.destroy
    redirect_with_flash("notice","Category has been deleted", categories_path)
  end

  private

  def load_category
    @category = Category.find_by_id(params[:id])
    unless @category
      redirect_with_flash("notice","Category does not exist", categories_path)
    end
  end

end
