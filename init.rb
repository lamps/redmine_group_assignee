require 'redmine'
require 'dispatcher'

require 'groups_helper_patch'
require 'groups_controller_patch'
require 'users_patch'

# ruby bug???? http://www.redmine.org/issues/4257
require_dependency 'project'

#RAILS_DEFAULT_LOGGER.info 'Starting Groups plugin for Redmine'

# http://theadmin.org/articles/how-to-modify-core-redmine-classes-from-a-plugin/
Dispatcher.to_prepare :redmine_group_assignee do
  require_dependency 'principal' 
  require_dependency 'user'

  GroupsController.send(:include, GroupsAssignedsPlugin::GroupsControllerPatch)
  GroupsHelper.send(:include, GroupsAssignedsPlugin::GroupsHelperPatch)
  User.send(:include, GroupsAssignedsPlugin::UserPatch)
end

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
require 'group_edit_hooks'

