require 'groups_helper'

module GroupsAssignedsPlugin
  module GroupsHelperPatch 
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethodsForGroupsHelper)
      base.send(:extend, ClassMethodsForGroupsHelper)
      # Rails.logger.warn "GroupsHelperPatch: after: GroupsHelper.methods is: " + base.methods.sort().join(',')
  
      base.class_eval do
        alias_method_chain :group_settings_tabs, :assignees
      end    
    end
    
    module InstanceMethodsForGroupsHelper
      # Adds a "group assignee tab" to the user page
      def group_settings_tabs_with_assignees(groupname) 
        tabs = group_settings_tabs_without_assignees(groupname)
        tabs << { :name => 'assignees',:controller => 'groupext',:action => :index,:partial => 'groupext/assignee', :label => :label_GroupsAssignedsPlugin_assignee}
        return tabs
      end    
      
    end
    module ClassMethodsForGroupsHelper
  
      def autocomplete_for_assigned(group)
	scope = User.active.sorted.not_in_group_assignees(group).like(params[:q])
	principal_count = scope.count
	principal_pages = Redmine::Pagination::Paginator.new principal_count, 100, params['page']
	principals = scope.offset(principal_pages.offset).limit(principal_pages.per_page).all

	s = content_tag('div', principals_check_box_tags('user_ids[]', principals), :id => 'principals')

	links = pagination_links_full(principal_pages, principal_count, :per_page_links => false) {|text, parameters, options|
	  link_to text, autocomplete_for_user_group_path(group, parameters.merge(:q => params[:q], :format => 'js')), :remote => true
	}

	s + content_tag('p', links, :class => 'pagination')
      end

    end
  end    
end
