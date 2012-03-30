module GroupsAssignedsPlugin
  module GroupsControllerPatch
    
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethodsForGroupsController)
  
      base.class_eval do
        unloadable # Send unloadable so it will not be unloaded in development
        skip_before_filter :require_admin
        before_filter :require_admin, :only => [:index, :show, :new, :edit, :create, :update, :destory, :edit_membership, :destory_membership]
        before_filter :require_group_assignee
        class << self
          
        end      
      end
    end
    
    module InstanceMethodsForGroupsController
      def require_group_assignee
        return unless require_login
        if !GroupsAssigned.find(:first, :conditions => ['user_id = ?', User.current.id]) and !User.current.admin? 
          render_403
          return false
        end
        true
      end 
    end  
    
  end
end