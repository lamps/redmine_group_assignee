ActionController::Routing::Routes.draw do |map|
  map.plugin_groups 'groups/menugroup', :controller => "groups", :action => 'menugroup'
  map.plugin_groups 'groups/edit_groupassigne', :controller => "groups", :action => 'edit_groupassigne'
end