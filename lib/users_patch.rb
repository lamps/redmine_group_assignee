
module GroupsAssignedsPlugin
  module UserPatch    
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethodsForUser)
      
      base.class_eval do          
        unloadable # Send unloadable so it will not be unloaded in development                
        has_many :groups_assigneds, :dependent => :destroy
          
        scope :in_group_assignee, lambda { |group_id, user_id|
            add_query = "and gu.group_id = #{group_id}" if group_id              
            where("#{User.table_name}.id IN (SELECT gu.user_id FROM #{table_name_prefix}groups_assigneds#{table_name_suffix} gu WHERE gu.user_id = ? #{add_query})", user_id)
          }
        
        scope :in_group_assignees, lambda { |group|
            group_id = group.is_a?(Group) ? group.id : group.to_i
            where("#{User.table_name}.id IN (SELECT gu.user_id FROM #{table_name_prefix}groups_assigneds#{table_name_suffix} gu WHERE gu.group_id = ?)", group_id )
          }
          
        scope :not_in_group_assignees, lambda { |group|
            group_id = group.is_a?(Group) ? group.id : group.to_i
            #Rails.logger.warn "in not_in_group_assignees #{group_id}"
            where("#{User.table_name}.id NOT IN (SELECT gu.user_id FROM #{table_name_prefix}groups_assigneds#{table_name_suffix} gu WHERE gu.group_id = ?)", group_id )
          }       
   
        class << self
        
        end
      end
    end
    
    module InstanceMethodsForUser
      def assignee? (group_id=nil)
        User.active.in_group_assignee(group_id, User.current.id).any?
      end
      
    end
  
  end
end
