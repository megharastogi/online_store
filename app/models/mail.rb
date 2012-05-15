class Mail < ActionMailer::Base
  
  layout 'mail'
  
  #fix add a setup_email method for common variables
  #fixed
  
  def new_user_mail(user)
    setup_mail  
    @recipients  = "#{user.email}"
    @body[:user] = user
  end
  
  def reset_password_mail(user)
    setup_mail  
    @recipients  = "#{user.email}"
    @body[:user] = user
  end  
  
  protected
  
  def setup_mail
     @from = "admin@vincomm.com"  
     @sent_on     = Time.zone.now
     @content_type = 'text/html'
     @subject     = "[Vincomm]"
  end    
    
end
