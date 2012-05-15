class Order < ActiveRecord::Base
  
  has_many :items
  belongs_to :user
  
  validates_presence_of :user_id 
  
  def order_products
    @products = []
    self.items.each do |i|
      @product = Product.find_by_id(i.product_id)
      @products << [@product, i.quantity]
    end
    return @products   
  end
  
  def self.add_order_items(user_id,cart_items)
     @order = Order.create(:user_id => user_id)
     cart_items.each_key do |product|
       Item.create(:order_id =>"#{@order.id}",:product_id => product, :quantity => cart_items[product])
     end
     @products = @order.order_products
     return @order,@products
  end  
  
  def order_price
    @price =0
    self.items.each do |product|
        @product = Product.find_by_id(product.product_id)
        @price = @price + (@product.price * product.quantity)
    end    
    return @price
  end
  
  def set_paypal_values
    values =  {  
      :business => "contac_1288699073_biz@gmail.com",
      :cmd => '_xclick',
      :return => "http://localhost:3000",
      :amount=> self.order_price,
      :item_name => "my-online-store-order #{self.id}",
      :quantity => 1,
      :item_number => self.id,
      :invoice => Time.now
    }  
    return values.map {|k,v| "#{k}=#{v}"}.join("&") 
  end  
  
end
