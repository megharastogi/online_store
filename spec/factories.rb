Factory.define :admin do |a|
  a.role 'admin'
  a.id '1'
  a.association(:account)
end  

Factory.define :account do |a|
  
end

Factory.define :account1 , :parent => :account do |a|
  a.name 'admin'
  a.email 'admin@vincomm.com'
  a.resource_type 'Admin'
  a.resource_id '1'
  a.password 'pass123'
  a.password_confirmation 'pass123'
end  

Factory.define :user do |a|
  a.id '2'
  a.association(:account)
end  


Factory.define :account2 , :parent => :account do |a|
  a.name 'abcd'
  a.email 'abcd@gmail.com'
  a.resource_type 'User'
  a.resource_id '2'
  a.password 'pass123'
  a.password_confirmation 'pass123'
end  


Factory.define :category do |c|
  c.name 'category'
  c.description 'category description'  
end  

Factory.define :product do |p|
  p.name 'product1'
  p.description 'this is product description'
  p.price 12
  p.quantity '2'
  p.weight '23'
  p.dimension 's123'
  p.sku '32r23dfs'
  p.id 2
end  

Factory.define :image do |i|
  
end

Factory.define :image1, :parent => :image do |i|
  i.filename '1261992972_twitter.png'
  i.content_type 'image/png'
  i.size '123'
  i.height '123'
  i.width '128'
  i.kind '1'
end  
Factory.define :image2, :parent => :image do |i|
  i.filename '1261992972_twitter.png'
  i.content_type 'image/png'
  i.size '123'
  i.height '123'
  i.width '128'
end
Factory.define :image3, :parent => :image do |i|
  i.filename '1261992972_twitter.png'
  i.content_type 'image/png'
  i.size '123'
  i.height '123'
  i.width '128'
end