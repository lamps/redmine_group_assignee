class GroupEditHook < Redmine::Hook::ViewListener
  def view_my_account_contextual(context={ })
     
    user = context[:user]
    if User.current.assignee?
      ret_str = '| '
      ret_str << link_to(l(:label_GroupsAssignedsPlugin_groups), { :controller => 'groupext', :action => 'menugroup' },:class => 'icon icon-groupext')
      return ret_str
   end
 end
 
  # Adds stylesheet tags
  def view_layouts_base_html_head(context)    
    stylesheet_link_tag('tab_content_assignees', :plugin => :redmine_group_assignee)
  end
  
  # render_on( :view_my_account_contextual, :inline => "| <%= link_to(l(:label_GroupsAssignedsPlugin_groups), { :controller => 'groupext', :action => 'menugroup' }) %>")
end