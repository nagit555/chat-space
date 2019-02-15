class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @join_groups = Member.where(user_id: current_user.id)
  end

  def create
  end
end
