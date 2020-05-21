module CurrentUserAdminRoleHelper

def set_admin_user
  @building = Building.find(params[:id])
  @engagements = Engagement.where({:building_id => @building.id, :user_id => current_user.id, role: "admin"  })
    if @engagements.count > 0
       true
    end
  end
end
