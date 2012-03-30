class CreateGroupsAssigneds < ActiveRecord::Migration
  def self.up
    create_table :groups_assigneds do |t|
      t.column :id, :integer
      t.column :group_id, :integer
      t.references :user
    end    
  end
  
  def self.down
    drop_table :groups_assigneds
  end
end
