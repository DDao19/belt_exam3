class OrganizationsController < ApplicationController

  def create
    organization = Organization.create(name: params[:name], description: params[:description], user_id: current_user.id)
    if organization.valid?
      return redirect_to groups_path
    end
  else
    flash[:errors] = ["Org name must be at least 5 characters. Description must be at least 10 characters"]
    return redirect_to groups_path
  end

  def show
    @organization = Organization.find(params[:id])
    @membership = Membership.where(organization_id: params[:id])
  end

  def update
    joined = Membership.find_by(user_id: current_user.id, organization_id: params[:id])
    if !joined.blank?
      flash[:errors] = ["You already joined the group dummy..."]
      return redirect_to groups_path
    end
    joiner = User.find(current_user.id)
    membership = Membership.create(user_id: current_user.id, organization_id: params[:id])
    return redirect_to groups_path
  end

  def destroy
    member_gone = Membership.find_by(user_id: current_user.id, organization_id: params[:id])
    if member_gone.blank?
      flash[:errors] = ["You haven't joined the group yet..."]
      return redirect_to groups_path
    end
    Membership.find_by(user_id: current_user.id, organization_id: params[:id]).destroy

    return redirect_to groups_path
  end




end
