module GroupsAssignedsPlugin
  module GroupsHelperPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethodsForGroupsHelper)
  
      base.class_eval do
        alias_method_chain :group_settings_tabs, :assignees
      end    
    end
    
    module InstanceMethodsForGroupsHelper
      # Adds a "group assignee tab" to the user page
      def group_settings_tabs_with_assignees
        tabs = group_settings_tabs_without_assignees      
        tabs << { :name => 'assignees',:controller => 'groupext',:action => :index,:partial => 'groupext/assignee', :label => :label_GroupsAssignedsPlugin_assignee}
        return tabs
      end    
      
    end
  end    
  
end