class GroupextController < ApplicationController
  before_filter :require_group_assignee  
  
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end
  
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        
        groupAssignee = GroupsAssigned.new
        groupAssignee.group_id = @group.id
        groupAssignee.user_id = User.current.id
        groupAssignee.save!
        
        format.html {
          flash[:notice] = l(:notice_successful_create)
          redirect_to(params[:continue] ?  { :controller => 'groupext', :action => 'new' } : { :controller => 'groupext', :action => 'menugroup' })
        }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = l(:notice_successful_update)
        format.html { 
          redirect_to( :controller => 'groupext', :action => 'menugroup')
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit_groupassigne" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def autocomplete_for_assigned
    @not_in_assignees = User.active.not_in_group_assignees(params[:group_id]).like(params[:q]).all(:limit => 300)
    render :layout => false
  end
  
  def add_group_assignee
    User.find_all_by_id(params[:user_ids]).each do |users|
      groupAssignee = GroupsAssigned.new
      groupAssignee.group_id = params[:group_id]
      groupAssignee.user_id = users.id
      groupAssignee.save!
    end          
 
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html { redirect_to :controller => 'groups', :action => 'edit', :id => params[:group_id], :tab => 'assignees' }
      format.js {
        render(:update) {|page|
          page.replace_html "tab-content-assignees", :partial => 'groupext/assignee' , :controller => 'groups', :action => 'edit', :id => params[:group_id] 
        }
      }
    end
  end
  
  def delete_group_assignee
    GroupsAssigned.deleteAssignee(params[:group_id],params[:user_id])
    
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html { redirect_to :controller => 'groups', :action => 'edit', :id => params[:group_id], :tab => 'assignees' }
      format.js {
        render(:update) {|page|
          page.replace_html "tab-content-assignees", :partial => 'groupext/assignee' , :controller => 'groups', :action => 'edit', :id => params[:group_id] 
        }
      }
    end
  end
  
  def menugroup
    @groups = Group.find(:all, :order => 'lastname')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end
  
  def edit_groupassigne
    @group = Group.find(params[:group_id], :include => :projects)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end
  
  def require_group_assignee
    return unless require_login
    if !GroupsAssigned.find(:first, :conditions => ['user_id = ?', User.current.id]) and !User.current.admin? 
      render_403
      return false
    end
    true
  end 
end
