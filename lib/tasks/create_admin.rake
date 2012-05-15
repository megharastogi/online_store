namespace :admin do
  desc "This creates an admin"
  task :create => :environment do
    Admin.create(:account_attributes => {:name => "admin" , :email => "admin@vincomm.com" ,
                              :password => "pass123",:password_confirmation => "pass123"}, :role => "admin")
  end  
end 