ActionController::Routing::Routes.draw do |map|
  
  map.plugin_groups 'groupext/edit_groupassigne', :controller => "groupext", :action => 'edit_groupassigne'

  map.plugin_groups 'groupext/add_group_assignee', :controller => 'groupext',:action => 'add_group_assignee'
  map.plugin_groups 'groupext/autocomplete_for_assigned', :controller => 'groupext',:action => 'autocomplete_for_assigned'
  map.plugin_groups 'groupext/delete_group_assignee', :controller => 'groupext',:action => 'delete_group_assignee'

  map.plugin_groups 'groupext/menugroup', :controller => "groupext", :action => 'menugroup'
  map.plugin_groups 'groupext/new', :controller => "groupext", :action => 'new'
  map.plugin_groups 'groupext/update', :controller => "groupext", :action => 'update'
  map.plugin_groups 'groupext/create', :controller => "groupext", :action => 'create'

end

