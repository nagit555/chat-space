class MessagesController < ApplicationController
  def index
#    @messages = Message.where(group_id: params[:group_id]).order('created_at ASC')
    @group = Group.find(params[:group_id])
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @join_groups = Member.where(user_id: current_user.id)
  end

  def create
    @message = Message.new(body: message_params[:body], image: message_params[:image], user_id: current_user.id, group_id: params[:group_id])
    if @message.save
      redirect_to group_messages_path(params[:group_id])
    else
      redirect_to group_messages_path(params[:group_id]), alert: "メッセージを入力してください。"
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :image)
    end
end
