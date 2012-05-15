# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def active_nav(controller,action)
    if (action == "all" || action_name == action) && controller_name == controller
        return "current"    
    end      
  end    
    
end
