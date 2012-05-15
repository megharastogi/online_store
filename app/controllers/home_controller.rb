class HomeController < ApplicationController
  
  def show
    @lastest_featured_product = Product.lastest_featured_product
    @featured_products = Product.featured_products - [@lastest_featured_product]
  end
    
end
