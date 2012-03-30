module GroupextHelper
  def groupassinge_settings_tabs
    tabs = [ {:name => 'general', :partial => 'groupext/general', :label => :label_general},
             {:name => 'users', :partial => 'groups/users', :label => :label_user_plural}
           ]
  end
end

