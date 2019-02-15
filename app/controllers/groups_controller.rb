class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(name: group_params[:name])
    # binding.pry
    if @group.save
      if group_params[:user_ids].length == 1
        @group.destroy
        flash[:alert] = "チャットメンバーを選んでください"
        render :new
      else
        group_params[:user_ids].each.with_index(1) do |user_id, i|
          member = Member.create(user_id: user_id, group_id: @group.id)
        end
        redirect_to root_path, notice: 'グループを作成しました。'
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
    def group_params
      params.require(:group).permit(:name, user_ids: [])
    end
    # def group_params
    #   params.require(:group).permit(:name, :user_ids)
    # end
end
