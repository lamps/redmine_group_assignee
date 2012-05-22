module GroupsAssignedsPlugin
  module GroupPatch    
    def self.included(base) # :nodoc:
      base.class_eval do          
        unloadable # Send unloadable so it will not be unloaded in development                
        has_many :groups_assigneds, :dependent => :destroy

        class << self
        
        end
      end
    end
  end
end