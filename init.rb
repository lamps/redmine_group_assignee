require 'redmine'
require 'dispatcher' unless Rails::VERSION::MAJOR >= 3

if Rails::VERSION::MAJOR >= 3
   ActionDispatch::Callbacks.to_prepare do
      require 'groups_helper_patch'
      require 'groups_controller_patch'
      require 'users_patch'
      require 'groups_patch'
      require 'group_edit_hooks'

      require_dependency 'project'
      require_dependency 'principal' 
      require_dependency 'user'
      require_dependency 'group'
      Rails.logger.warn "Sending updates:"

      GroupsController.send(:include, GroupsAssignedsPlugin::GroupsControllerPatch)
      GroupsHelper.send(:include, GroupsAssignedsPlugin::GroupsHelperPatch)
      User.send(:include, GroupsAssignedsPlugin::UserPatch)
      Group.send(:include, GroupsAssignedsPlugin::GroupPatch)

   end
else
   Dispatcher.to_prepare :redmine_group_assignee  do
      require 'groups_helper_patch'
      require 'groups_controller_patch'
      require 'users_patch'
      require 'groups_patch'
      require 'group_edit_hooks'

      require_dependency 'project'
      require_dependency 'principal' 
      require_dependency 'user'
      require_dependency 'group'

      GroupsController.send(:include, GroupsAssignedsPlugin::GroupsControllerPatch)
      GroupsHelper.send(:include, GroupsAssignedsPlugin::GroupsHelperPatch)
      User.send(:include, GroupsAssignedsPlugin::UserPatch)
      Group.send(:include, GroupsAssignedsPlugin::GroupPatch)
   end
end

# ruby bug???? http://www.redmine.org/issues/4257

#RAILS_DEFAULT_LOGGER.info 'Starting Groups plugin for Redmine'

# http://www.redmine.org/projects/redmine/wiki/Plugin_Tutorial
Redmine::Plugin.register :redmine_group_assignee do
  name 'Redmine Groups plugin'
  author 'jj. ofsoul'
  description 'Assignee Redmine Group'
  version '1.0.0'
  url 'https://github.com/lamps/redmine_group_assignee'
  author_url 'https://github.com/lamps/redmine_group_assignee'
  requires_redmine :version_or_higher => '1.2.0'
      
#  menu :top_menu, :groups, 
#      { :controller => 'groupext', :action => 'menugroup' }, 
#      { :caption => :label_GroupsAssignedsPlugin_groups, :if => Proc.new {!User.current.admin? and User.current.assignee?} }
end

# http://www.redmine.org/projects/redmine/wiki/Hooks
# http://www.redmine.org/projects/redmine/wiki/Hooks_List

