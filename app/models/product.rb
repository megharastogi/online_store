class Product < ActiveRecord::Base
  
  has_many :images, :as => :record
   
  belongs_to :category 
      
  validates_presence_of :name ,:description,:price,:quantity,:dimension,:weight,:sku,:category_id
  validates_uniqueness_of :name,:sku
  validates_numericality_of :price ,  :greater_than => 0.0 ,:unless => lambda{|t| t.price.blank? }
  validates_numericality_of :quantity ,:greater_than => 0 , :unless => lambda{|t| t.quantity.blank? }
  validates_numericality_of :weight , :greater_than => 0 , :unless => lambda{|t| t.weight.blank? }
  validates_inclusion_of :category, :in => Category.all, :if => lambda{|t| !t.category.blank?}  
  
  named_scope :featured_products , :conditions => {:is_featured => true } , :limit => 5
  
  
  def self.lastest_featured_product
    @product = Product.find(:first ,:conditions => {:is_featured => true } , :order => "updated_at DESC")
  end  
  
  def image_type(kind_id)
    self.images.each do |i|
        if i.kind.to_i == kind_id.to_i
            return i
        end    
    end  
    return []        
  end

end
