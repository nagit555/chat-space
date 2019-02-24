class MessagesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @message = Message.new
    @messages = @group.messages.includes(:user)
    @join_groups = Member.where(user_id: current_user.id)

    respond_to do |format|
      format.html { render :index }
      format.json
    end
  end

  def create
    @message = Message.new(body: message_params[:body], image: message_params[:image], user_id: current_user.id, group_id: params[:group_id])
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(params[:group_id]) }
        format.json
      end
    else
      redirect_to group_messages_path(params[:group_id]), alert: "メッセージを入力してください。"
    end
  end

  private
    def message_params
      params.require(:message).permit(:body, :image)
    end
end
