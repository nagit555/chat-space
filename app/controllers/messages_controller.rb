class MessagesController < ApplicationController
  def index
    @join_groups = Member.where(user_id: current_user.id)
    # binding.pry
  end

  def create
  end
end
