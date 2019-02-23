class GroupsController < ApplicationController

  def index
    @join_groups = Member.where(user_id: current_user.id)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: group_params[:name])
    if @group.save
      if group_params[:user_ids].length == 0
        @group.destroy
        flash[:alert] = "チャットメンバーを選んでください"
        render :new
      else
        @group.users = User.where(id: group_params[:user_ids])
        redirect_to root_path, notice: 'グループを作成しました。'
      end
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(name: group_params[:name])
      @group.users = User.where(id: group_params[:user_ids])
      redirect_to root_path, notice: "グループ情報を更新しました。"
    else
      render :edit
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, user_ids: [])
    end
end
