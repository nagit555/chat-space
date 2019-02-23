class UsersController < ApplicationController

  def index
    @users = User.where("name LIKE ?", "#{params[:query]}%").where.not(id: current_user.id)
    respond_to do |format|
      format.html { redirect_to :root }
      format.json
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "プロフィールが更新されました。"
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
