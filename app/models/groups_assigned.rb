class GroupsAssigned < ActiveRecord::Base
  belongs_to :user
   
  def self.deleteAssignee(group_id,user_id)
    delete_all(:group_id => group_id, :user_id => user_id )
  end
  
end