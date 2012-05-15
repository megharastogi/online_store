require 'digest/sha1'
 
class Account < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  belongs_to :resource, :polymorphic => true
  
  validates_presence_of     :name 
  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_length_of       :email,    :within => 6..100
  validates_uniqueness_of   :email
  
  attr_protected  :crypted_password, :salt, :resource_type, :resource_id

  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find_by_email(email.downcase) 
    u && u.authenticated?(password) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def admin?
    resource_type == 'Admin'
  end
  
  def generate_reset_token
    self.update_attribute('reset_token', Digest::SHA1.hexdigest(Time.now.to_s).slice(0..15))  
    Mail.deliver_reset_password_mail(self)
  end  
  
  def generate_activation_token
     self.update_attribute('activation_token', Digest::SHA1.hexdigest(Time.now.to_s).slice(0..15))  
     Mail.deliver_new_user_mail(self)
  end      
  
  private
  
    def password_required?
      crypted_password.blank? || !password.nil? 
    end  
  
end
