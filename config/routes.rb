if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    #get '/groupext/menugroup' , :to 'groupext#menugroup', :as 'groupext'

    match 'groupext/menugroup',  :to => 'groupext#menugroup', :via => [:get, :post]
    match 'groupext/add_group_assignee/:group_id', :to => 'groupext#add_group_assignee', :via => [:get, :post], :as => :groupext_add_group_assignee
    match 'groupext/autocomplete_for_assigned/:group_id', :to => 'groupext#autocomplete_for_assigned', :via => [:get, :post], :as => :groupext_autocomplete_for_assigned
    match 'groupext/delete_group_assignee/:group_id/:user_id', :to => 'groupext#delete_group_assignee', :via => [:get, :post], :as => :groupext_delete_group_assignee
    match 'groupext/edit_groupassigne/:group_id', :to => 'groupext#edit_groupassigne', :via => [:get,:post] 

    
    match 'groupext/new',  :to => 'groupext#new', :via => [:get, :post]
    match 'groupext/update',  :to => 'groupext#update', :via => [:get, :post]
    match 'groupext/create',  :to => 'groupext#create', :via => [:get, :post]

  end
else
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
end
