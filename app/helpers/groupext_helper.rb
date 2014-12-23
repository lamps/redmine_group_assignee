require 'groups_helper'

module GroupextHelper
  def groupassinge_settings_tabs
    tabs = [ {:name => 'general', :partial => 'groupext/general', :label => :label_general},
             {:name => 'users', :partial => 'groups/users', :label => :label_user_plural}
           ]
  end

  def autocomplete_for_assigned(group)
	@not_in_assignees = User.active.not_in_group_assignees(group.id).like(params[:q]).all(:limit => 300)
	render :layout => false
  end
end

