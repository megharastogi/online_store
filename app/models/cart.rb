class Cart 
  
  attr_accessor :cart_items
  
  def add_product(product)
    @cart_items ||= {}
    if @cart_items.has_key? product.id
        @cart_items[product.id] = @cart_items[product.id] + 1
    else 
        @cart_items[product.id] = 1
    end
  end  
  
  def cart_price
    @price = 0
    @cart_items.each_key do |p|
      @product = Product.find_by_id(p)
      @price += (@product.price * @cart_items[p])
    end  
    return @price
  end  
      
  def show_cart
    @products = []
    @cart_items.each_key do |p|
      @products << [Product.find_by_id(p),@cart_items[p]]
    end 
    return @products
  end  
  
  
  def update_cart(product,quantity)
    quantity.to_i == 0 ? "error" : @cart_items[product] = quantity.to_i 
  end  
  
end
